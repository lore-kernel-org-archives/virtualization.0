From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [RFC] kvmtool: add support for modern virtio-pci
Date: Wed, 18 Nov 2015 10:23:49 -0500
Message-ID: <564C9805.8080800@oracle.com>
References: <1447823472-17047-1-git-send-email-sasha.levin@oracle.com>
	<1447834972.23726.92.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447834972.23726.92.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, andre.przywara@arm.com, will.deacon@arm.com, josh@joshtriplett.org, virtualization@lists.linux-foundation.org, penberg@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 11/18/2015 03:22 AM, Gerd Hoffmann wrote:
> /me goes undust the kvmtool patches for seabios.
> 
> (see https://www.kraxel.org/cgit/seabios/commit/?h=kvmtool,
> build with CONFIG_KVMTOOL=y + CONFIG_DEBUG_LEVEL=9)
> 
> nilsson kraxel ~# ~kraxel/projects/kvmtool/lkvm run --name seabios
> --firmware /home/kraxel/projects/seabios/out-bios-kvmtool/bios.bin
> --disk /vmdisk/cloud/persistent/Fedora-Cloud-Base-22-20150521.x86_64.raw
>   # lkvm run -k /boot/vmlinuz-3.10.0-324.el7.x86_64 -m 448 -c 4 --name
> seabios

Thanks for testing! I didn't even thing about seabios as a testing target.

I tried to do what you described, and built seabios with:

$ cat .config | grep 'KVMTOOL\|DEBUG'
CONFIG_KVMTOOL=y
CONFIG_DEBUG_LEVEL=9

But when booting, it just hangs on:

$ ./lkvm run --firmware ~/seabios/out/bios.bin -d dummy
  # lkvm run -k /boot/vmlinuz-4.2.0-17-generic -m 448 -c 4 --name guest-12566


And same result with --virtio-legacy...

What did I miss?


Thanks,
Sasha
