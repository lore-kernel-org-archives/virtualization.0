From: Chris Malley <mail@chrismalley.co.uk>
Subject: Re: [Lguest] [patch 34/43] lguest: Block driver using virtio.
Date: Fri, 28 Sep 2007 12:32:36 +0100
Message-ID: <1190979156.25555.13.camel@feisty>
References: <20070926063618.956228976@rustcorp.com.au>
	<20070926063651.250184396@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070926063651.250184396@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

rusty@rustcorp.com.au wrote:
> +	sprintf(vblk->disk->disk_name, "vd%c", virtblk_index++);

Update lguest documentation to reflect the new virtual block device name.

Signed-off-by: Chris Malley <mail@chrismalley.co.uk>
---

--- Documentation/lguest/lguest.txt.orig	2007-09-28 12:00:32.000000000 +0100
+++ Documentation/lguest/lguest.txt	2007-09-28 12:04:30.000000000 +0100
@@ -69,7 +69,7 @@
 
 - Run an lguest as root:
 
-      Documentation/lguest/lguest 64 vmlinux --tunnet=192.168.19.1 --block=rootfile root=/dev/lgba
+      Documentation/lguest/lguest 64 vmlinux --tunnet=192.168.19.1 --block=rootfile root=/dev/vda
 
    Explanation:
     64: the amount of memory to use, in MB.
@@ -80,10 +80,10 @@
     --tunnet=192.168.19.1: configures a "tap" device for networking with this
        IP address.
 
-    --block=rootfile: a file or block device which becomes /dev/lgba
+    --block=rootfile: a file or block device which becomes /dev/vda
        inside the guest.
 
-    root=/dev/lgba: this (and anything else on the command line) are
+    root=/dev/vda: this (and anything else on the command line) are
        kernel boot parameters.
 
 - Configuring networking.  I usually have the host masquerade, using
