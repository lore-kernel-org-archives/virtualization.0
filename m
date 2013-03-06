From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tcm_vhost: Add hotplug/hotunplug support
Date: Wed, 06 Mar 2013 15:28:00 +0100
Message-ID: <51375270.7060703@redhat.com>
References: <1362475027-12018-1-git-send-email-asias@redhat.com>
	<20130305121125.GA823@redhat.com> <5135F150.1060206@redhat.com>
	<20130305143416.GG2256@redhat.com>
	<1362523912.7905.208.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362523912.7905.208.camel@haakon2.linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 05/03/2013 23:51, Nicholas A. Bellinger ha scritto:
> For making progress with Paolo's vhost-scsi branch on my side, this was
> still being blocked by bios boot hangs:
> 
> http://www.spinics.net/lists/target-devel/msg03830.html
> 
> Paolo & Co, any ideas on the latter..?

Nope.  Asias, do you have time to look at it?  Only patches 3 and 4 in
that series are needed, they are at

http://article.gmane.org/gmane.comp.emulators.qemu/192143
http://article.gmane.org/gmane.comp.emulators.qemu/192147

(vhost_scsi_set_endpoint and vhost_scsi_clear_endpoint need to be
integrated in vhost_scsi_start and vhost_scsi_stop).

Paolo
