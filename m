From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PULL] virtio
Date: Thu, 03 Nov 2011 08:37:01 +1030
Message-ID: <87hb2mtbzu.fsf__9276.78583325378$1320278788$gmane$org@rustcorp.com.au>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com>
	<1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>
	<8739e7uy87.fsf@rustcorp.com.au> <1320209564.9173.6.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1320209564.9173.6.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Wang Sheng-Hui <shhuiw@gmail.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 02 Nov 2011 06:52:44 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> Since the PCI spec allows you to have the MSI-X table and the PBA in
> completely different regions pointed by two different BARs, we did so in
> kvm tools and have BAR 1 pointing to the MSI-X table, and BAR 2 pointing
> to the PBA ( - we *already* provided the second BAR and used it for
> something else).

Got it!  Thanks for the explanation.

Cheers,
Rusty.
