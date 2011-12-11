From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 6/11] virtio_pci: don't use the legacy driver if we find the
	new PCI capabilities.
Date: Sun, 11 Dec 2011 15:45:46 +1030
Message-ID: <87fwgrofi5.fsf@rustcorp.com.au>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <871usfgxg9.fsf@rustcorp.com.au>
	<1323551918.32487.34.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1323551918.32487.34.camel@lappy>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 10 Dec 2011 23:18:38 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> On Thu, 2011-12-08 at 21:08 +1030, Rusty Russell wrote:
> > With module option to override.  I assume I can call
> > pci_find_capability() before pci_request_regions? 
> 
> I don't think thats safe.

Actually, a number of drivers do it first thing in probe()
(eg. drivers/char/agp/intel-agp.c).

So I think it's easiest right at the start.  I've changed that.

Thanks,
Rusty.
