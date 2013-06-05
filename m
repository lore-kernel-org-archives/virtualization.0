From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 05 Jun 2013 14:15:19 -0700
Message-ID: <51AFAA67.2010200@zytor.com>
References: <87fvwytpa1.fsf@rustcorp.com.au>
	<20130604064216.GD19433@redhat.com> <871u8g67d6.fsf@codemonkey.ws>
	<20130605140936.GB10604@redhat.com> <87ehcgr3wq.fsf@codemonkey.ws>
	<20130605151953.GA25987@redhat.com> <87bo7ktvaw.fsf@codemonkey.ws>
	<20130605162029.GB26561@redhat.com> <87li6obd2r.fsf@codemonkey.ws>
	<20130605194317.GA30923@redhat.com>
	<20130605195216.GA31172@redhat.com> <87hahcqobu.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87hahcqobu.fsf@codemonkey.ws>
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

On 06/05/2013 01:45 PM, Anthony Liguori wrote:
> 
> But if you want to boot from the 16th device, the BIOS needs to solve
> this problem anyway.
> 

No.  Just have the BIOS plumb the path to the device it wants to boot
from.  Problem solved.

	-hpa
