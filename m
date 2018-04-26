From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event
	handling code to use the failover framework
Date: Wed, 25 Apr 2018 17:18:31 -0700
Message-ID: <20180425171831.785f412b__4391.78039455346$1524701809$gmane$org@xeon-e3>
References: <1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
	<20180420082802.6ca37e4c@xeon-e3>
	<20180420160058.GB2150@nanopsycho.orion>
	<20180423100406.71b95f74@xeon-e3>
	<20180423202204-mutt-send-email-mst@kernel.org>
	<20180423104440.2fe6cfd2@xeon-e3>
	<20180423205019-mutt-send-email-mst@kernel.org>
	<CADGSJ20ge75T+ddxtUBT4d9m1i3=HLOAHJEoS7Cg0bqnXrutwA@mail.gmail.com>
	<20180423230037-mutt-send-email-mst@kernel.org>
	<CADGSJ22WMxXEtR9QpRa9_ZqgmTbgWHZz2j4hsUnRJrM9zTsW4w@mail.gmail.com>
	<20180426011221-mutt-send-email-mst@kernel.org>
	<CADGSJ20vck5V8JCoF0Tq9PWfBu7QYPDvg0yAZ_8Xkig7TKU7Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CADGSJ20vck5V8JCoF0Tq9PWfBu7QYPDvg0yAZ_8Xkig7TKU7Lw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Siwei Liu <loseweigh@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 25 Apr 2018 15:57:57 -0700
Siwei Liu <loseweigh@gmail.com> wrote:

> >
> > I think ideally the infrastructure should suppport flexible matching of
> > NICs - netvsc is already reported to be moving to some kind of serial
> > address.
> >  
> As Stephen said, Hyper-V supports the serial UUID thing from day-one.
> It's just the Linux netvsc guest driver itself does not leverage that
> ID from the very beginging.
> 
> Regards,
> -Siwei

I am working on that.  The problem is that it requires some messy work
to go from VF netdevice back to PCI device and from there to the PCI hyperv
host infrastructure to find the serial number.

I was hoping that the serial number would also match the concept of PCI Express
device serial number. But that is a completely different ID :-( 
The PCI-E serial number is a hardware serial number more like MAC address.
The Hyper-V serial number is more like PCI slot value.
