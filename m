From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [systemd-devel] udev virtio by-path naming
Date: Wed, 1 Mar 2017 03:30:07 +0000
Message-ID: <20170301033007.GG29552__29477.9287338772$1488675853$gmane$org@in.waw.pl>
References: <de55b0f4-4582-cf06-4b0d-12c2282406a8@linux.vnet.ibm.com>
	<20170220170041.68c9bf4f.cornelia.huck@de.ibm.com>
	<9cb1f5ff-0a5b-4d0a-16f6-887c7658795a@linux.vnet.ibm.com>
	<CALVzVJZhZTNbZp1EB9cT82YxUnbUZZ+ZPo7Od8CWz5C3faN1AA@mail.gmail.com>
	<14ac3e2c-180b-cb18-fd68-268dc5d85f8b@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <14ac3e2c-180b-cb18-fd68-268dc5d85f8b@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: systemd-devel <systemd-devel@lists.freedesktop.org>, Michal Sekletar <msekleta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 28, 2017 at 09:47:42AM +0100, Viktor Mihajlovski wrote:
> >>>> One could argue about back-level compatibility, but virtio by-path
> >>>> naming has changed multiple times. We have seen virtio-pci-virtio<n>
> >>>> (not predictable), pci-<busid> and virtio-pci-<busid> already. It
> >>>> might be a good time now to settle on a common approach for all
> >>>> virtio types.
> >>>>
> >>>> For the reasons above, I'd vote for <subsystem>-<busid>, which
> >>>> would work for PCI and CCW, not sure about ARM MMIO though.

It seems that there's agreement that <subsystem>-<busid> is the right
approach.

Ideally we would keep the virtio-pci-<busid> links as they appear
right now, for backwards compatibility, just for the pci devices, and
mark them as deprecated (dunno where, maybe just in NEWS), and add the
code to make the links.

I haven't looked at the code, maybe we just do this with the right
udev rule, and also stick the deprecation comment there?

Zbyszek
