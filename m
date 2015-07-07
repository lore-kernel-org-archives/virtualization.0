From: Thomas Huth <huth@tuxfamily.org>
Subject: Re: I can read/write in virtio BLK Device, but I can't run a hello
	world program in it
Date: Tue, 7 Jul 2015 08:55:04 +0200
Message-ID: <20150707085504.11d15a8b@thh440s>
References: <C03726BC-3011-4295-9ED6-EF31E98EE7BD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <C03726BC-3011-4295-9ED6-EF31E98EE7BD@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Ganis Zulfa Santoso <ganis.zulfa@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 7 Jul 2015 10:52:01 +0900
Ganis Zulfa Santoso <ganis.zulfa@gmail.com> wrote:

> Hi Linux Virtualization Mailing List Members,
> 
> I am trying to develop a driver for virtio blk device in guest.

Why don't you simply use the driver that is already available in the
kernel?

> I can safely mount the virtual blk device with: mount /dev/vda /mnt/
> in /mnt/ I can read & write the device. But when I run a simple hello world program in /mnt/root/, this error happens:

Have you already verified that you can successfully read the _right_
data from your block device? I.e. something like

mount /dev/xxx /mnt
cp helloworld_static /mnt/root/helloworld_static
umount /mnt  # just to make sure that it is not cached
mount /dev/xxx /mnt
md5sum helloworld_static
md5sum /mnt/root/helloworld_static

... and then compare the two md5sums whether they are the same?

 Thomas
