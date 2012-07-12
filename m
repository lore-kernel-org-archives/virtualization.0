From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH] hw/virtio-scsi: Set max_target=0 during vhost-scsi
	operation
Date: Thu, 12 Jul 2012 15:08:38 -0700
Message-ID: <1342130918.18004.116.camel__47381.4887846403$1342130932$gmane$org@haakon2.linux-iscsi.org>
References: <1342040128-29176-1-git-send-email-nab@linux-iscsi.org>
	<CAEH94LgNkuomE3-8auuEWhe1hGoF3qpMs45G8fsY1xjvQe=2QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAEH94LgNkuomE3-8auuEWhe1hGoF3qpMs45G8fsY1xjvQe=2QQ@mail.gmail.com>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael
	S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Zhi Yong Wu <wuzhy@cn.ibm.com>, linux-iscsi-target-dev@googlegroups.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Zhi,

On Thu, 2012-07-12 at 14:59 +0800, Zhi Yong Wu wrote:
> thanks, it is applied to my vhost_scsi git tree
> git://github.com/wuzhy/qemu.git vhost-scsi
> 

Thanks for picking up this patch in your vhost-scsi tree.

As mentioned off-list, I'd like to rebase to a more recent qemu.git to
include megasas 8708EM2 HBA emulation from Dr. Hannes so we can
experiment with a few more types of target setups.  ;)

I'll likely do this on my local branch for now, but if you have the
extra cycles please feel free to update vhost-scsi to the latest
qemu.git HEAD so we can have both vhost-scsi + megasas HBA emulation in
the same working tree.

Depending upon how long we'll need to hold vhost-scsi patches
out-of-tree (hopefully it's less than infinity ;) a qemu/vhost-scsi
working tree on kernel.org might also be helpful.

Thanks!

--nab
