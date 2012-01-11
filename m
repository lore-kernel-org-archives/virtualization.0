From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 07:51:47 +1100
Message-ID: <1326315107.23910.134.camel@pasglop>
References: <87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com> <871us0om2t.fsf@rustcorp.com.au>
	<20111220113718.GF3913@redhat.com> <878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com> <8762gj6q5r.fsf@rustcorp.com.au>
	<4F0D8EFA.3010503@codemonkey.ws> <20120111151230.GA20570@redhat.com>
	<4F0DA7A5.7050600@codemonkey.ws> <20120111152129.GB20570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111152129.GB20570@redhat.com>
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
Cc: Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2012-01-11 at 17:21 +0200, Michael S. Tsirkin wrote:
> 
> Possible but doesn't let us layer nicely to allow unchanged drivers
> that work with all transports (new pci, old pci, non pci).
> Something like a command VQ would be a generic transport
> that can be hidden behind  config->set(...).

I agree, a command VQ (And possibly a status VQ) would be generally
useful.

Cheers,
Ben.
