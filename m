From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC] kvmtool: add support for modern virtio-pci
Date: Wed, 18 Nov 2015 18:52:20 +0100
Message-ID: <1447869140.23691.15.camel__48610.6311473579$1447869161$gmane$org@redhat.com>
References: <1447823472-17047-1-git-send-email-sasha.levin@oracle.com>
	<1447834972.23726.92.camel@redhat.com> <564C9805.8080800@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <564C9805.8080800@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <sasha.levin@oracle.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, andre.przywara@arm.com, will.deacon@arm.com, josh@joshtriplett.org, virtualization@lists.linux-foundation.org, penberg@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> Thanks for testing! I didn't even thing about seabios as a testing target.

Not surprising, support isn't upstream, ran into a bunch of issues[1][2]
last time I tried to combine the two, ran into some issues and nobody
seemed to care, so the seabios patches where just sitting in a branch in
my repo ...

> $ cat .config | grep 'KVMTOOL\|DEBUG'
> CONFIG_KVMTOOL=y
> CONFIG_DEBUG_LEVEL=9

Hmm, 'CONFIG_KVMTOOL=y > .config; make olddefconfig' should give you a
working configuration.

Setting 'CONFIG_DEBUG_LEVEL=9' is useful for trouble-shooting as it
makes the virtio drivers more verbose, but not mandatory to have.

Serial line support is needed to get output:

CONFIG_DEBUG_SERIAL=y
CONFIG_DEBUG_SERIAL_PORT=0x3f8

Also I think rom size must be 128k b/c kvmtool expects it to be that
way:

CONFIG_ROM_SIZE=128

But those are the defaults, and after "make olddefconfig" you should
already have them ...

cheers,
  Gerd

[1] kernel doesn't find pci (can be worked around by tweaking kernel
    command line in boot loader config).
[2] kernel virtio drivers fail to initialize (probably device reset
    not working properly).
