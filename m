From: Amit Shah <amit.shah@redhat.com>
Subject: [RFC PATCH v3] virito-serial: A guest <-> host interface
Date: Sat,  4 Jul 2009 00:52:03 +0530
Message-ID: <1246648925-23732-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



Hello,

This is a new iteration of the patches that implement virtio-serial. Changes
include:

* Adding support for port hot-add
* Creating ports at specific ids that can be bound to specific apps / usage
* Cleanups

This code still doesn't get rid of the support for assigning names
to ports but it just has to be ripped out.

Comments welcome.

		Thanks,
			Amit.
