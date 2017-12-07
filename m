From: achiad shochat <achiad.mellanox@gmail.com>
Subject: Re: [RFC] virtio-net: help live migrate SR-IOV devices
Date: Thu, 7 Dec 2017 09:28:58 +0200
Message-ID: <CAEHy93JG-X-5qtrU2wUmxfMzKc9G3GDNL_H-FXsmAmfwvoO+vg__26017.8102450029$1512631742$gmane$org@mail.gmail.com>
References: <0fb552d4-1bfc-e130-4fc1-87b83873916d@redhat.com>
	<CAEHy93LneRXNWo64uyN2dfyDX6t18WN+YwVF2RXXLRnr0=Jhww@mail.gmail.com>
	<20171130155612-mutt-send-email-mst@kernel.org>
	<780cf854-83e1-b2a4-0f07-74372a972ca6@oracle.com>
	<20171203065759-mutt-send-email-mst@kernel.org>
	<CAEHy93+yhRtTQub0xk5W1jKRNisrcRBtNexcwRfWdSKPm5a4Gw@mail.gmail.com>
	<20171203093524.26491cd0@xeon-e3>
	<CAEHy93LEr5h81KGfJBr5Z4ZKaeWEWwQL1LYfZNXoVF_HB6TQGw@mail.gmail.com>
	<CAKgT0Uf5gta+CNM3ReybV3qNMJXqoT9BHvMjKRbd=PYOPQrQaA@mail.gmail.com>
	<CAEHy93Kw-GePsraaAkVZNbOwt=rDPMVjmwuU22004LHCAoSSFA@mail.gmail.com>
	<20171205211603-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171205211603-mutt-send-email-mst@kernel.org>
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
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, Hannes Frederic Sowa <hannes@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Shannon Nelson <shannon.nelson@oracle.com>, Achiad <achiad@mellanox.com>, Peter Waskiewicz Jr <peter.waskiewicz.jr@intel.com>, netdev <netdev@vger.kernel.org>, "Singhai,
	Anjali" <anjali.singhai@intel.com>, Andy Gospodarek <gospo@broadcom.com>, Or Gerlitz <gerlitz.or@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 5 December 2017 at 21:20, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Dec 05, 2017 at 11:59:17AM +0200, achiad shochat wrote:
>> Then we'll have a single solution for both netvsc and virtio (and any
>> other PV device).
>> And we could handle the VF DMA dirt issue agnostically.
>
> For the record, I won't block patches adding this kist to virtio
> on the basis that they must be generic. It's not a lot
> of code, implementation can come first, prettify later.

It's not a lot of code either way.
So I fail to understand why not to do it right from the beginning.
For the record...

>
> But we do need to have a discussion about how devices are paired.
> I am not sure using just MAC works. E.g. some passthrough
> devices don't give host ability to set the MAC.
> Are these worth worrying about?
>
> --
> MST
