From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 02/16] adapt lguest launcher to per-cpuness
Date: Thu, 20 Dec 2007 11:33:42 -0200
Message-ID: <11981576492807-git-send-email-gcosta__26322.6345916793$1198157943$gmane$org@redhat.com>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<11981576442148-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981576442148-git-send-email-gcosta@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch makes uses of pread() and pwrite() in lguest launcher
to communicate the vcpu id to the lguest driver. The id is kept in
a thread variable, which means we'll span in the future, vcpus as
threads. But right now, only the infrastructure is out there.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 Documentation/lguest/lguest.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/lguest/lguest.c b/Documentation/lguest/lguest.c
index 9b0e322..c406ba9 100644
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -79,6 +79,9 @@ static void *guest_base;
 /* The maximum guest physical address allowed, and maximum possible. */
 static unsigned long guest_limit, guest_max;
 
+/* a per-cpu variable indicating whose vcpu is currently running */
+static unsigned int __thread vcpu_id;
+
 /* This is our list of devices. */
 struct device_list
 {
@@ -554,7 +557,7 @@ static void wake_parent(int pipefd, int lguest_fd)
 			else
 				FD_CLR(-fd - 1, &devices.infds);
 		} else /* Send LHREQ_BREAK command. */
-			write(lguest_fd, args, sizeof(args));
+			pwrite(lguest_fd, args, sizeof(args), 0);
 	}
 }
 
@@ -1511,7 +1514,8 @@ static void __attribute__((noreturn)) run_guest(int lguest_fd)
 		int readval;
 
 		/* We read from the /dev/lguest device to run the Guest. */
-		readval = read(lguest_fd, &notify_addr, sizeof(notify_addr));
+		readval = pread(lguest_fd, &notify_addr,
+				sizeof(notify_addr), vcpu_id);
 
 		/* One unsigned long means the Guest did HCALL_NOTIFY */
 		if (readval == sizeof(notify_addr)) {
@@ -1521,17 +1525,22 @@ static void __attribute__((noreturn)) run_guest(int lguest_fd)
 		/* ENOENT means the Guest died.  Reading tells us why. */
 		} else if (errno == ENOENT) {
 			char reason[1024] = { 0 };
-			read(lguest_fd, reason, sizeof(reason)-1);
+			pread(lguest_fd, reason, sizeof(reason)-1, vcpu_id);
 			errx(1, "%s", reason);
 		/* EAGAIN means the Waker wanted us to look at some input.
 		 * Anything else means a bug or incompatible change. */
 		} else if (errno != EAGAIN)
 			err(1, "Running guest failed");
 
-		/* Service input, then unset the BREAK to release the Waker. */
-		handle_input(lguest_fd);
-		if (write(lguest_fd, args, sizeof(args)) < 0)
-			err(1, "Resetting break");
+		if (!vcpu_id) {
+			/*
+			 * Service input, then unset the BREAK to
+			 * release the Waker.
+			 */
+			handle_input(lguest_fd);
+			if (pwrite(lguest_fd, args, sizeof(args), 0) < 0)
+				err(1, "Resetting break");
+		}
 	}
 }
 /*
@@ -1582,6 +1591,7 @@ int main(int argc, char *argv[])
 	devices.lastdev = &devices.dev;
 	devices.next_irq = 1;
 
+	vcpu_id = 0;
 	/* We need to know how much memory so we can set up the device
 	 * descriptor and memory pages for the devices as we parse the command
 	 * line.  So we quickly look through the arguments to find the amount
-- 
1.5.0.6
