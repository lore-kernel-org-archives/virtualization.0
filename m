From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 RFC] virtio-spec: flexible configuration layout
Date: Fri, 11 Nov 2011 14:54:31 +1030
Message-ID: <87aa83qoao.fsf__33584.7932998606$1320986085$gmane$org@rustcorp.com.au>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com>
	<1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>
	<8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com>
	<20111108214021.GA4538@redhat.com>
	<20111109195901.GA28155@redhat.com> <1320870287.3730.6.camel@lappy>
	<20111109205208.GA28599@redhat.com>
	<1320872248.3730.11.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1320872248.3730.11.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, penberg@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 09 Nov 2011 22:57:28 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> On Wed, 2011-11-09 at 22:52 +0200, Michael S. Tsirkin wrote:
> > On Wed, Nov 09, 2011 at 10:24:47PM +0200, Sasha Levin wrote:
> > > It'll be a bit harder deprecating it in the future.
> > 
> > Harder than ... what ?
> 
> Harder than allowing devices not to present it at all if new layout
> config is used. Right now the simple implementation is to use MMIO for
> config and device specific, and let it fallback to legacy for ISR and
> notifications (and therefore, this is probably how everybody will
> implement it), which means that when you do want to deprecate legacy,
> there will be extra work to be done then, instead of doing it now.

Indeed, I'd like to see two changes to your proposal:

(1) It should be all or nothing.  If a driver can find the virtio header
    capability, it should only use the capabilties.  Otherwise, it
    should fall back to legacy.  Your draft suggests a mix is possible;
    I prefer a clean failure (ie. one day don't present a BAR 0 *at
    all*, so ancient drivers just fail to load.).

(2) There's no huge win in keeping the same layout.  Let's make some
    cleanups.  There are more users ahead of us then behind us (I
    hope!).

But I think this is the right direction!

Thanks,
Rusty.
