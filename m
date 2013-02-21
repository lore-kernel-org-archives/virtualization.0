From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 17/16 V2] virtio-scsi: use virtqueue_add_sgs for command
	buffers
Date: Thu, 21 Feb 2013 17:04:28 +1030
Message-ID: <874nh6gop7.fsf@rustcorp.com.au>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
	<1361353639-10623-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<5124BEE8.9010006@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5124BEE8.9010006@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>, Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Asias He <asias@redhat.com> writes:
> On 02/20/2013 05:47 PM, Wanlong Gao wrote:
>> Using the new virtqueue_add_sgs function lets us simplify the queueing
>> path.  In particular, all data protected by the tgt_lock is just gone
>> (multiqueue will find a new use for the lock).
>> 
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>
> Reviewed-by: Asias He <asias@redhat.com>

Applied.

Unfortunately these won't be in until *next* merge window...

Cheers,
Rusty.
