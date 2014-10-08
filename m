From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC 00/11] qemu: towards virtio-1 host support
Date: Wed, 8 Oct 2014 11:04:28 +0200
Message-ID: <20141008110428.6fc78115.cornelia.huck@de.ibm.com>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
	<54349246.6000905@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54349246.6000905@amacapital.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 07 Oct 2014 18:24:22 -0700
Andy Lutomirski <luto@amacapital.net> wrote:

> On 10/07/2014 07:39 AM, Cornelia Huck wrote:
> > This patchset aims to get us some way to implement virtio-1 compliant
> > and transitional devices in qemu. Branch available at
> > 
> > git://github.com/cohuck/qemu virtio-1
> > 
> > I've mainly focused on:
> > - endianness handling
> > - extended feature bits
> > - virtio-ccw new/changed commands
> 
> At the risk of some distraction, would it be worth thinking about a
> solution to the IOMMU bypassing mess as part of this?

I think that is a whole different issue. virtio-1 is basically done - we
just need to implement it - while the IOMMU/DMA stuff certainly needs
more discussion. Therefore, I'd like to defer to the other discussion
thread here.
