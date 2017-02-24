From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Subject: Re: udev virtio by-path naming
Date: Fri, 24 Feb 2017 10:56:28 +0100
Message-ID: <9cb1f5ff-0a5b-4d0a-16f6-887c7658795a@linux.vnet.ibm.com>
References: <de55b0f4-4582-cf06-4b0d-12c2282406a8@linux.vnet.ibm.com>
	<20170220170041.68c9bf4f.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170220170041.68c9bf4f.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Sekletar <msekleta@redhat.com>
Cc: systemd-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 20.02.2017 17:00, Cornelia Huck wrote:
> On Mon, 20 Feb 2017 15:34:49 +0100
> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> =

>> Hi,
>>
>> with systemd > v229 all virtio block devices will receive persistent
>> device names in the format /dev/disk-by/virtio-pci-<busid>, the
>> last component being the udev built-in path_id.
>>
>> This naming introduces some issues.
>>
>> First and obvious, there are virtio implementations not based
>> on PCI, like virtio-ccw (currently only on s390) and virtio-mmio
>> (for which I can't speak). This results in persistent names like
>> /dev/disk-by/virtio-pci-0.0.0001, where the bus id is a CCW id.
>> One seemingly obvious remedy would be to make the path_id return
>> virtio-ccw-<busid> or more generally virtio-<subsystem>-<busid>,
>> both easily done with small patches to systemd-udev.
>>
>> But then, I find this naming scheme somewhat weird.
>> A virtio disk shows up as a regular PCI function on the PCI
>> bus side by side with other (non-virtio) devices. The naming otoh
>> suggests that virtio-pci is a subsystem of its own, which is simply
>> incorrect from a by-path perspective.
> =

> From the ccw perspective, this is quite similar: The virtio proxy
> device shows up on the ccw bus, just like e.g. a dasd device shows up
> on the ccw bus.
> =

>>
>> Using just the plain PCI path id is actually sufficient to identify
>> a virtio disk by its path. This would be in line with virtio
>> network interface path names which use the plain PCI naming.
> =

> Same for ccw: The id on the ccw bus (devno) is already unique and
> persistent.
> =

>>
>> One could argue about back-level compatibility, but virtio by-path
>> naming has changed multiple times. We have seen virtio-pci-virtio<n>
>> (not predictable), pci-<busid> and virtio-pci-<busid> already. It
>> might be a good time now to settle on a common approach for all
>> virtio types.
>>
>> For the reasons above, I'd vote for <subsystem>-<busid>, which
>> would work for PCI and CCW, not sure about ARM MMIO though.
>> Opinions?
> =

> I'm not sure whether there is any reason to make virtio special,
> although this depends upon what virtio-mmio looks like in the Linux
> device model (any arm folks here?)
> =

> In the end, I'd be happy with any naming scheme that does not include
> 'pci' for non-pci devices.
> =

Michal, as author of commit f073b1b3c0f4f0df1b0bd61042ce85fb5d27d407
that introduced this behavior: can you comment on the reasoning for
prepending virtio- to the bus, i.e. why would pci-<busid> not
sufficiently identify the device?

-- =


Mit freundlichen Gr=FC=DFen/Kind Regards
   Viktor Mihajlovski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=F6deritz
Gesch=E4ftsf=FChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
