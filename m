From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [RFC 1/9] notifier: add validity check and notify function
Date: Tue, 24 Jul 2012 22:33:58 +0000
Message-ID: <1343169246-17636-2-git-send-email-nab__37361.7121288136$1343169449$gmane$org@linux-iscsi.org>
References: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: target-devel <target-devel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

Event notifiers that have not had the event_notifier_init() function
called on them are invalid.  The event_notifier_valid() function checks
whether or not an event notifier is valild.  This can be used to check
whether a notifier is in use or not.

It sometimes useful to notify the event notifier, for example when vhost
is on the receiving end of the event notifier and qemu needs to notify
it.  The event_notifier_notify() function will signal the eventfd and
increment it by one.

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 event_notifier.c |   21 +++++++++++++++++++++
 event_notifier.h |    4 ++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/event_notifier.c b/event_notifier.c
index 2c207e1..efe00ea 100644
--- a/event_notifier.c
+++ b/event_notifier.c
@@ -25,6 +25,7 @@ void event_notifier_init_fd(EventNotifier *e, int fd)
 
 int event_notifier_init(EventNotifier *e, int active)
 {
+    assert(!event_notifier_valid(e));
 #ifdef CONFIG_EVENTFD
     int fd = eventfd(!!active, EFD_NONBLOCK | EFD_CLOEXEC);
     if (fd < 0)
@@ -39,6 +40,12 @@ int event_notifier_init(EventNotifier *e, int active)
 void event_notifier_cleanup(EventNotifier *e)
 {
     close(e->fd);
+    e->fd = -1;
+}
+
+bool event_notifier_valid(EventNotifier *e)
+{
+    return e->fd != -1;
 }
 
 int event_notifier_get_fd(EventNotifier *e)
@@ -65,3 +72,17 @@ int event_notifier_test_and_clear(EventNotifier *e)
     int r = read(e->fd, &value, sizeof(value));
     return r == sizeof(value);
 }
+
+int event_notifier_notify(EventNotifier *e)
+{
+    uint64_t value = 1;
+    int r;
+
+    assert(event_notifier_valid(e));
+    r = write(e->fd, &value, sizeof(value));
+    if (r < 0) {
+        return -errno;
+    }
+    assert(r == sizeof(value));
+    return 0;
+}
diff --git a/event_notifier.h b/event_notifier.h
index f0ec2f2..eea10a9 100644
--- a/event_notifier.h
+++ b/event_notifier.h
@@ -15,6 +15,8 @@
 
 #include "qemu-common.h"
 
+#define EVENT_NOTIFIER_INITIALIZER ((EventNotifier){ .fd = -1 })
+
 struct EventNotifier {
     int fd;
 };
@@ -24,9 +26,11 @@ typedef void EventNotifierHandler(EventNotifier *);
 void event_notifier_init_fd(EventNotifier *, int fd);
 int event_notifier_init(EventNotifier *, int active);
 void event_notifier_cleanup(EventNotifier *);
+bool event_notifier_valid(EventNotifier *e);
 int event_notifier_get_fd(EventNotifier *);
 int event_notifier_set(EventNotifier *);
 int event_notifier_test_and_clear(EventNotifier *);
 int event_notifier_set_handler(EventNotifier *, EventNotifierHandler *);
+int event_notifier_notify(EventNotifier *e);
 
 #endif
-- 
1.7.2.5
