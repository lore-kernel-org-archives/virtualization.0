From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/11] RFC: PCI using capabilitities
Date: Fri, 09 Dec 2011 16:47:39 +1030
Message-ID: <87d3byfev0.fsf@rustcorp.com.au>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <1323358657.32487.9.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1323358657.32487.9.camel@lappy>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 08 Dec 2011 17:37:37 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> Which leads me to the question: Are MMIO vs MMIO reads/writes not
> ordered?

That seems really odd, especially being repeatable.

BTW, that's an address, not a pfn now.

Cheers,
Rusty.
