From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] virtio-blk: Disable callback in virtblk_done()
Date: Fri, 28 Sep 2012 15:03:56 +0800
Message-ID: <50654BDC.4060805@redhat.com>
References: <1348540577-7474-1-git-send-email-asias@redhat.com>
	<5061BAED.9020205@redhat.com> <87ehlo497o.fsf@rustcorp.com.au>
	<5063F6D2.7030908@redhat.com> <87fw623chz.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87fw623chz.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/28/2012 02:08 PM, Rusty Russell wrote:
> Asias He <asias@redhat.com> writes:
>>> I forgot about the cool hack which MST put in to defer event updates
>>> using disable_cb/enable_cb.
>>
>> Hmm, are you talking about virtqueue_enable_cb_delayed()?
> 
> Just the fact that virtqueue_disable_cb() prevents updates of
> used_index, and then we do the update in virtqueue_enable_cb().

Okay.

-- 
Asias
