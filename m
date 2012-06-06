From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3] virtio_blk: unlock vblk->lock during kick
Date: Wed, 6 Jun 2012 10:03:17 +0100
Message-ID: <CAJSP0QVSmbkJV4hz6-U=YxK-9G2=B=TosR3LLpY29VRq_6p40Q@mail.gmail.com>
References: <1338541986-8083-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<20120604111507.GB28673@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120604111507.GB28673@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: khoa@us.ibm.com, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 4, 2012 at 12:15 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Jun 01, 2012 at 10:13:06AM +0100, Stefan Hajnoczi wrote:
>> Other block drivers (cciss, rbd, nbd) use spin_unlock_irq() so I followe=
d that.
>> To me this seems wrong: blk_run_queue() uses spin_lock_irqsave() but we =
enable
>> irqs with spin_unlock_irq(). =A0If the caller of blk_run_queue() had irqs
>> disabled and we enable them again this could be a problem, right? =A0Can=
 someone
>> more familiar with kernel locking comment?
>
> Why take the risk? =A0What's the advantage of enabling them here? VCPU is
> not running while the hypervisor is processing the notification anyway.
> And the next line returns from the function so the interrupts will get
> enabled.

I agree.  After looking through the code more following Asias' call
chain, I'm happy to use spin_unlock() and not worry about the irq
part.

Will fix.

Stefan
