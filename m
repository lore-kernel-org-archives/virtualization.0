From: Ganis Zulfa Santoso <ganis.zulfa@gmail.com>
Subject: Re: I can read/write in virtio BLK Device,
	but I can't run a hello world program in it
Date: Tue, 7 Jul 2015 16:33:33 +0900
Message-ID: <E9B176EE-AD9B-44C6-8829-8F2C5E5AEADA@gmail.com>
References: <C03726BC-3011-4295-9ED6-EF31E98EE7BD@gmail.com>
	<20150707085504.11d15a8b@thh440s>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150707085504.11d15a8b@thh440s>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Huth <huth@tuxfamily.org>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


> Thomas Huth <huth@tuxfamily.org> wrote:
> 
> Why don't you simply use the driver that is already available in the
> kernel?

I am using a custom hypervisor, the available driver is not suitable for it.

> 
> Have you already verified that you can successfully read the _right_
> data from your block device? I.e. something like
> 
> mount /dev/xxx /mnt
> cp helloworld_static /mnt/root/helloworld_static
> umount /mnt  # just to make sure that it is not cached
> mount /dev/xxx /mnt
> md5sum helloworld_static
> md5sum /mnt/root/helloworld_static
> 
> ... and then compare the two md5sums whether they are the same?

They are different. Thank you so much. I am truly thankful. 

> 
> Thomas
