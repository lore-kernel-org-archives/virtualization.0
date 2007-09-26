From: rusty@rustcorp.com.au
Subject: [patch 42/43] lguest: Example launcher handle guests not being
	ready for input
Date: Wed, 26 Sep 2007 16:37:00 +1000
Message-ID: <20070926063652.741032118@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=handle-console-overflow.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We currently discard console and network input when the guest has no
input buffers.  This patch changes that, so that we simply stop
listening to that fd until the guest refills its input buffers.

This is particularly important because hvc_console without interrupts
does backoff polling and so often lose characters if we discard.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |  107 +++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff -r 7f216dff74d3 Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Wed Sep 26 14:48:31 2007 +1000
+++ b/Documentation/lguest/lguest.c	Wed Sep 26 14:48:31 2007 +1000
@@ -598,15 +598,17 @@ static void wake_parent(int pipefd, int 
 		select(devices.max_infd+1, &rfds, NULL, NULL, NULL);
 		/* Is it a message from the Launcher? */
 		if (FD_ISSET(pipefd, &rfds)) {
-			int ignorefd;
+			int fd;
 			/* If read() returns 0, it means the Launcher has
 			 * exited.  We silently follow. */
-			if (read(pipefd, &ignorefd, sizeof(ignorefd)) == 0)
+			if (read(pipefd, &fd, sizeof(fd)) == 0)
 				exit(0);
-			/* Otherwise it's telling us there's a problem with one
-			 * of the devices, and we should ignore that file
-			 * descriptor from now on. */
-			FD_CLR(ignorefd, &devices.infds);
+			/* Otherwise it's telling us to change what file
+			 * descriptors we're to listen to. */
+			if (fd >= 0)
+				FD_SET(fd, &devices.infds);
+			else
+				FD_CLR(-fd - 1, &devices.infds);
 		} else /* Send LHREQ_BREAK command. */
 			write(lguest_fd, args, sizeof(args));
 	}
@@ -657,18 +659,6 @@ static void *_check_pointer(unsigned lon
 }
 /* A macro which transparently hands the line number to the real function. */
 #define check_pointer(addr,size) _check_pointer(addr, size, __LINE__)
-
-/* This simply sets up an iovec array where we can put data to be discarded.
- * This happens when the Guest doesn't want or can't handle the input: we have
- * to get rid of it somewhere, and if we bury it in the ceiling space it will
- * start to smell after a week. */
-static void discard_iovec(struct iovec *iov, unsigned int *num)
-{
-	static char discard_buf[1024];
-	*num = 1;
-	iov->iov_base = discard_buf;
-	iov->iov_len = sizeof(discard_buf);
-}
 
 /* This function returns the next descriptor in the chain, or vq->vring.num. */
 static unsigned next_desc(struct virtqueue *vq, unsigned int i)
@@ -812,12 +802,13 @@ static bool handle_console_input(int fd,
 
 	/* First we need a console buffer from the Guests's input virtqueue. */
 	head = get_vq_desc(dev->vq, iov, &out_num, &in_num);
-	if (head == dev->vq->vring.num) {
-		/* If they're not ready for input, we warn and set up to
-		 * discard. */
-		warnx("console: no dma buffer!");
-		discard_iovec(iov, &in_num);
-	} else if (out_num)
+
+	/* If they're not ready for input, stop listening to this file
+	 * descriptor.  We'll start again once they add an input buffer. */
+	if (head == dev->vq->vring.num)
+		return false;
+
+	if (out_num)
 		errx(1, "Output buffers in console in queue?");
 
 	/* This is why we convert to iovecs: the readv() call uses them, and so
@@ -827,15 +818,16 @@ static bool handle_console_input(int fd,
 		/* This implies that the console is closed, is /dev/null, or
 		 * something went terribly wrong. */
 		warnx("Failed to get console input, ignoring console.");
-		/* Put the input terminal back and return failure (meaning,
-		 * don't call us again). */
+		/* Put the input terminal back. */
 		restore_term();
+		/* Remove callback from input vq, so it doesn't restart us. */
+		dev->vq->handle_output = NULL;
+		/* Stop listening to this fd: don't call us again. */
 		return false;
 	}
 
-	/* If we actually read the data into the Guest, tell them about it. */
-	if (head != dev->vq->vring.num)
-		add_used_and_trigger(fd, dev->vq, head, len);
+	/* Tell the Guest about the new input. */
+	add_used_and_trigger(fd, dev->vq, head, len);
 
 	/* Three ^C within one second?  Exit.
 	 *
@@ -924,7 +916,8 @@ static bool handle_tun_input(int fd, str
 		/* FIXME: Actually want DRIVER_ACTIVE here. */
 		if (dev->desc->status & VIRTIO_CONFIG_S_DRIVER_OK)
 			warn("network: no dma buffer!");
-		discard_iovec(iov, &in_num);
+		/* We'll turn this back on if input buffers are registered. */
+		return false;
 	} else if (out_num)
 		errx(1, "Output buffers in network recv queue?");
 
@@ -938,9 +931,8 @@ static bool handle_tun_input(int fd, str
 	if (len <= 0)
 		err(1, "reading network");
 
-	/* If we actually read the data into the Guest, tell them about it. */
-	if (head != dev->vq->vring.num)
-		add_used_and_trigger(fd, dev->vq, head, sizeof(*hdr) + len);
+	/* Tell the Guest about the new packet. */
+	add_used_and_trigger(fd, dev->vq, head, sizeof(*hdr) + len);
 
 	verbose("tun input packet len %i [%02x %02x] (%s)\n", len,
 		((u8 *)iov[1].iov_base)[0], ((u8 *)iov[1].iov_base)[1],
@@ -948,6 +940,15 @@ static bool handle_tun_input(int fd, str
 
 	/* All good. */
 	return true;
+}
+
+/* This callback ensures we try again, in case we stopped console or net
+ * delivery because Guest didn't have any buffers. */
+static void enable_fd(int fd, struct virtqueue *vq)
+{
+	add_device_fd(vq->dev->fd);
+	/* Tell waker to listen to it again */
+	write(waker_fd, &vq->dev->fd, sizeof(vq->dev->fd));
 }
 
 /* This is the generic routine we call when the Guest uses LHCALL_NOTIFY. */
@@ -996,17 +997,22 @@ static void handle_input(int fd)
 		 * file descriptors and a method of handling them.  */
 		for (i = devices.dev; i; i = i->next) {
 			if (i->handle_input && FD_ISSET(i->fd, &fds)) {
+				int dev_fd;
+				if (i->handle_input(fd, i))
+					continue;
+
 				/* If handle_input() returns false, it means we
-				 * should no longer service it.
-				 * handle_console_input() does this. */
-				if (!i->handle_input(fd, i)) {
-					/* Clear it from the set of input file
-					 * descriptors kept at the head of the
-					 * device list. */
-					FD_CLR(i->fd, &devices.infds);
-					/* Tell waker to ignore it too... */
-					write(waker_fd, &i->fd, sizeof(i->fd));
-				}
+				 * should no longer service it.  Networking and
+				 * console do this when there's no input
+				 * buffers to deliver into.  Console also uses
+				 * it when it discovers that stdin is
+				 * closed. */
+				FD_CLR(i->fd, &devices.infds);
+				/* Tell waker to ignore it too, by sending a
+				 * negative fd number (-1, since 0 is a valid
+				 * FD number). */
+				dev_fd = -i->fd - 1;
+				write(waker_fd, &dev_fd, sizeof(dev_fd));
 			}
 		}
 	}
@@ -1154,11 +1160,11 @@ static void setup_console(void)
 	dev->priv = malloc(sizeof(struct console_abort));
 	((struct console_abort *)dev->priv)->count = 0;
 
-	/* The console needs two virtqueues: the input then the output.  We
-	 * don't care when they refill the input queue, since we don't hold
-	 * data waiting for them.  That's why the input queue's callback is
-	 * NULL.  */
-	add_virtqueue(dev, VIRTQUEUE_NUM, NULL);
+	/* The console needs two virtqueues: the input then the output.  When
+	 * they put something the input queue, we make sure we're listening to
+	 * stdin.  When they put something in the output queue, we write it to
+	 * stdout.  */
+	add_virtqueue(dev, VIRTQUEUE_NUM, enable_fd);
 	add_virtqueue(dev, VIRTQUEUE_NUM, handle_console_output);
 
 	verbose("device %u: console\n", devices.device_num++);
@@ -1270,8 +1276,9 @@ static void setup_tun_net(const char *ar
 	/* First we create a new network device. */
 	dev = new_device("net", VIRTIO_ID_NET, netfd, handle_tun_input);
 
-	/* Network devices need a receive and a send queue. */
-	add_virtqueue(dev, VIRTQUEUE_NUM, NULL);
+	/* Network devices need a receive and a send queue, just like
+	 * console. */
+	add_virtqueue(dev, VIRTQUEUE_NUM, enable_fd);
 	add_virtqueue(dev, VIRTQUEUE_NUM, handle_net_output);
 
 	/* We need a socket to perform the magic network ioctls to bring up the

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
