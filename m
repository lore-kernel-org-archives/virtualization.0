From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH 2/2] virtio: don't free memory until the underlying struct
	device has been released
Date: Sun, 04 Jan 2015 10:03:27 -0500
Message-ID: <54A9563F.3070902@oracle.com>
References: <1420228060-18721-1-git-send-email-sasha.levin@oracle.com>
	<1420228060-18721-2-git-send-email-sasha.levin@oracle.com>
	<20150104112641.GB4336@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150104112641.GB4336@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Sasha Levin <sasha.levin@oracle.com>
Cc: linux-kernel@vger.kernel.org, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 01/04/2015 06:26 AM, Michael S. Tsirkin wrote:
> On Fri, Jan 02, 2015 at 02:47:40PM -0500, Sasha Levin wrote:
>> > When releasing a virtio device, We can't free a struct virtio_device until the
>> > underlying struct device has been released, which might not happen immediately
>> > on device_unregister() even if that was the device's last reference.
>> > 
>> > Instead, free the memory only once we know the device is gone in the release
>> > callback.
>> > 
>> > Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> 
> Isn't this an old bug: do we need to copy stable on a fix?
> 
> What is the behaviour without this patch?
> Is there a way to make this cause a crash?

It will oops if CONFIG_DEBUG_KOBJECT_RELEASE is enabled. I guess
it needs to go to stable as well.


Thanks,
Sasha
