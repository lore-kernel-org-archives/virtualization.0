From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [RFC/PATCH 0/2] virtio console resize support
Date: Tue, 18 Nov 2008 12:45:03 +0100
Message-ID: <200811181245.03931.borntraeger__49025.2178199173$1227008911$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest@ozlabs.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

this patch set adds virtio console resize support.
Patch 1 implements the necessary changes in virtio_console
Patch 2 implements the config_changed callback for the s390 virtio transport

Patch 1 needs an additional patch against hvc_console 
( http://lkml.org/lkml/2008/11/18/121 )
to properly set the initial size.

If you are ok with these patches, can they go into linux-next via your tree?

An lguest implementation for the initial console size should be trivial. 
SIGWINCH would require the config_changed implementation which is currently 
in your tree.

Thanks
