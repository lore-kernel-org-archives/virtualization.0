From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 1/2] virtio-rng: fix stuck of hot-unplugging busy device
Date: Thu, 11 Sep 2014 22:20:42 +0930
Message-ID: <87wq9agw2l.fsf__356.138186953281$1410484707$gmane$org@rustcorp.com.au>
References: <1410329497-14349-1-git-send-email-akong@redhat.com>
	<1410329497-14349-2-git-send-email-akong@redhat.com>
	<20140910070354.GC29832@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140910070354.GC29832@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, Amos Kong <akong@redhat.com>
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:
> On (Wed) 10 Sep 2014 [14:11:36], Amos Kong wrote:
>> When we try to hot-remove a busy virtio-rng device from QEMU monitor,
>> the device can't be hot-removed. Because virtio-rng driver hangs at
>> wait_for_completion_killable().
>> 
>> This patch exits the waiting by completing have_data completion before
>> unregistering, resets data_avail to avoid the hwrng core use wrong
>> buffer bytes.
>> 
>> Signed-off-by: Amos Kong <akong@redhat.com>
>> Cc: stable@vger.kernel.org
>
> Reviewed-by: Amit Shah <amit.shah@redhat.com>

Thanks, applied.

Cheers,
Rusty.
