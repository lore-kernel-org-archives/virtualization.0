From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Thu, 06 Jun 2013 09:27:41 +1000
Message-ID: <1370474861.3766.247.camel@pasglop>
References: <20130604064216.GD19433@redhat.com>
	<871u8g67d6.fsf@codemonkey.ws> <20130605140936.GB10604@redhat.com>
	<87ehcgr3wq.fsf@codemonkey.ws> <20130605151953.GA25987@redhat.com>
	<87bo7ktvaw.fsf@codemonkey.ws> <20130605162029.GB26561@redhat.com>
	<87li6obd2r.fsf@codemonkey.ws> <20130605194317.GA30923@redhat.com>
	<87k3m8qofi.fsf@codemonkey.ws> <20130605211405.GA31928@redhat.com>
	<87d2s0mdh8.fsf@codemonkey.ws> <1370470797.3766.231.camel@pasglop>
	<87obbk88zr.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87obbk88zr.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2013-06-05 at 17:53 -0500, Anthony Liguori wrote:
> If strictly speaking it's just that MMIO is a bit faster, I'm not sure
> that complexity is worth it without seeing performance numbers first.

You mean PIO. I agree with all your points here. The only thing I
saw as an option would be to add a PIO BAR that is an exact mirror
of the MMIO BAR if and only if:

 - PIO is indeed significantly faster on platforms we care about

and/or

 - There is significant simplification in things like BIOSes in
   using PIO over MMIO

I personally don't care and would chose to use MMIO always including in
firmware on ppc.

Cheers,
Ben.
