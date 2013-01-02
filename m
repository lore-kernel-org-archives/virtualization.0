From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-blk: Don't free ida when disk is in use
Date: Wed, 02 Jan 2013 15:39:25 +1030
Message-ID: <87obh85fy2.fsf@rustcorp.com.au>
References: <1355946015-25879-1-git-send-email-agraf@suse.de>
	<878v8t1hri.fsf@rustcorp.com.au> <50D2D078.2070408@redhat.com>
	<F122515D-83AE-4161-A014-61BA6EEBA9A6@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <F122515D-83AE-4161-A014-61BA6EEBA9A6@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>, Asias He <asias@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Alexander Graf <agraf@suse.de> writes:

> On 20.12.2012, at 09:46, Asias He <asias@redhat.com> wrote:
>
>> On 12/20/2012 12:15 PM, Rusty Russell wrote:
>>> Alexander Graf <agraf@suse.de> writes:
>>> 
>>>> When a file system is mounted on a virtio-blk disk, we then remove it
>>>> and then reattach it, the reattached disk gets the same disk name and
>>>> ids as the hot removed one.
>>>> 
>>>> This leads to very nasty effects - mostly rendering the newly attached
>>>> device completely unusable.
>>>> 
>>>> Trying what happens when I do the same thing with a USB device, I saw
>>>> that the sd node simply doesn't get free'd when a device gets forcefully
>>>> removed.
>>>> 
>>>> Imitate the same behavior for vd devices. This way broken vd devices
>>>> simply are never free'd and newly attached ones keep working just fine.
>>>> 
>>>> Signed-off-by: Alexander Graf <agraf@suse.de>
>>> 
>>> I think deserves a CC:stable, no?
>
> I wanted to make sure people can comment on it first. But yes, it should go into stable when accepted.

Queued in my fixes branch, will go to Linus soon.

Thanks,
Rusty.
