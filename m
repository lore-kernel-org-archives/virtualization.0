From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] vhost: Add vhost_commit callback for SeaBIOS ROM region
	re-mapping
Date: Thu, 04 Apr 2013 07:26:57 +0200
Message-ID: <515D0F21.30403__41193.5573364191$1365053266$gmane$org@redhat.com>
References: <1364980511-25122-1-git-send-email-nab@linux-iscsi.org>
	<20130403094911.GB18179@redhat.com> <515BFF16.4000503@redhat.com>
	<20130403103438.GA18725@redhat.com> <515C05CB.6010505@redhat.com>
	<1365020604.11833.15.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365020604.11833.15.camel@haakon2.linux-iscsi.org>
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
Cc: kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 03/04/2013 22:23, Nicholas A. Bellinger ha scritto:
> 
> Just a heads up that PATCH-v2 for vhost-scsi-pci does not apply cleanly
> against the latest qemu.git/master.  Let me know if your OK with fixing
> the fuzz, or would prefer a -v3 re-spin before for applying to SCSI
> branch.  

I know, I'll fix it.

Paolo
