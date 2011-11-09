From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH RFC] virtio-spec: flexible configuration layout
Date: Wed, 09 Nov 2011 11:55:02 +0200
Message-ID: <1320832502.31056.22.camel__6241.44106773219$1320832635$gmane$org@lappy>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com> <1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com> <8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com> <20111108214021.GA4538@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111108214021.GA4538@redhat.com>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-11-08 at 23:40 +0200, Michael S. Tsirkin wrote:
> Here's a spec change documenting what my C patch does
> (almost - I tweaked the layout a bit, but the idea is the same).
> Some more cleanups are needed but I thought I'd send it
> for early flames/comments.
> 
> The idea is simple: we split functionally unrelated
> register groups to independent structures, and let
> the device place is anywhere using a capability
> in PCI configuration space.

I'm also wondering it it's ok to move virtio configuration out of virtio
space and into PCI space for archs that don't have PCI (such as ARM).

Would it mean they get stuck with legacy configuration (and no new
features)? Or is there an alternative for them?

-- 

Sasha.
