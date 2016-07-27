From: Jan Kara <jack@suse.cz>
Subject: Re: ext4 error when testing virtio-scsi & vhost-scsi
Date: Wed, 27 Jul 2016 17:56:08 +0200
Message-ID: <20160727155608.GC1659__11036.332374397$1469899210$gmane$org@quack2.suse.cz>
References: <CAMj5BkiVGQ4dAUY+wi-+O4qRdVS6YPiUP2BpsiE5y0r+2AhLgw@mail.gmail.com>
	<CAMj5BkiKC2m3PLHvoDWwyj9BQZ-Bg5mD0f1J0kZcpwroH+rR1g@mail.gmail.com>
	<CAMj5BkgSXjD+_GB_VPgizowyyJ1uYxLiKd7ehQmEdVvnuY55cA@mail.gmail.com>
	<20160712164324.GC11020@thunk.org>
	<CAMj5BkgTycMbfQpUVAV17ahYT1sGm6w3YDtpz0E--vN=tF55xA@mail.gmail.com>
	<CAMj5BkicJhB1Bk6q_ZT_nMKSPWf1XEGchtnGnMPFy=O_0x91hA@mail.gmail.com>
	<CAMj5BkifLL=3C5f0VZKhpNmi81em8P5VNupr7d7_aD=uo2Hwow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAMj5BkifLL=3C5f0VZKhpNmi81em8P5VNupr7d7_aD=uo2Hwow@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zhangfei Gao <zhangfei.gao@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, linux-ext4@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi!

On Wed 27-07-16 15:58:55, Zhangfei Gao wrote:
> Hi, Michael
> 
> I have met ext4 error when using vhost_scsi on arm64 platform, and
> suspect it is vhost_scsi issue.
> 
> Ext4 error when testing virtio_scsi & vhost_scsi
> 
> 
> No issue:
> 1. virtio_scsi, ext4
> 2. vhost_scsi & virtio_scsi, ext2
> 3.  Instead of vhost, also tried loopback and no problem.
> Using loopback, host can use the new block device, while vhost is used
> by guest (qemu).
> http://www.linux-iscsi.org/wiki/Tcm_loop
> Test directly in host, not find ext4 error.
> 
> 
> 
> Have issue:
> 1. vhost_scsi & virtio_scsi, ext4
> a. iblock
> b, fileio, file located in /tmp (ram), no device based.
> 
> 2, Have tried 4.7-r2 and 4.5-rc1 on D02 board, both have issue.
> Since I need kvm specific patch for D02, so it may not freely to switch
> to older version.
> 
> 3. Also test with ext4, disabling journal
> mkfs.ext4 -O ^has_journal /dev/sda
> 
> 
> Do you have any suggestion?

So can you mount the filesystem with errors=remount-ro to avoid clobbering
the fs after the problem happens? And then run e2fsck on the problematic
filesystem and send the output here?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
