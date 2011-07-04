From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: virtio scsi host draft specification, v3
Date: Mon, 4 Jul 2011 15:22:53 +0100
Message-ID: <CAJSP0QXwo_iMKtBJ1t38mde330HdCYtB_=HVa+3Ge8QPKeGQaQ__37557.9286287122$1309789416$gmane$org@mail.gmail.com>
References: <1504884387.187692.1307716550265.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<4DF71E28.6070009@suse.de> <4E0AE36B.9010500@redhat.com>
	<BANLkTik2AXXkWvV23OP1eDdLirP2N0PC3A@mail.gmail.com>
	<4E0D6C08.1040201@redhat.com> <4E0D73C4.5090608@suse.de>
	<4E0D86E0.1020406@redhat.com> <4E11C263.3010003@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4E11C263.3010003@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Hai Dong,Li" <haidongl@linux.vnet.ibm.com>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 4, 2011 at 2:38 PM, Hai Dong,Li <haidongl@linux.vnet.ibm.com> wrote:
> So if I understand correctly, virtio-scsi looks like an SCSI tranport
> protocol,
> such as iSCSI, FCP and SRP which use tcp/ip, FC and Infiniband RDMA
> respectively as the transfer media while virtio-scsi uses virtio, an virtual
> IO
> channel, as the transfer media?

Correct.

Stefan
