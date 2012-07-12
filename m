From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/virtio-scsi: Set max_target=0 during vhost-scsi
	operation
Date: Thu, 12 Jul 2012 08:24:08 +0200
Message-ID: <4FFE6D88.3020605__28314.0747611926$1342074273$gmane$org@redhat.com>
References: <1342040128-29176-1-git-send-email-nab@linux-iscsi.org>
	<CAEH94Lhkz81S9hV4_MHejs1c30YoCiwwKk1bCp3gyYNeq9-Veg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAEH94Lhkz81S9hV4_MHejs1c30YoCiwwKk1bCp3gyYNeq9-Veg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zhi Yong Wu <zwu.kernel@gmail.com>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, linux-iscsi-target-dev@googlegroups.com
List-Id: virtualization@lists.linuxfoundation.org

Il 12/07/2012 07:34, Zhi Yong Wu ha scritto:
> HI,
> 
> Do we need to maintain one QEMU branch to collect all useful latest
> patches for tcm_vhost support?  You know, those patches will not get
> merged into qemu.git/master.

Never say never, but the answer to your question is yes: please apply
this patch to your vhost-scsi branch and push it to github.

Paolo
