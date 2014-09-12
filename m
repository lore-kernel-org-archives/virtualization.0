From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 2/2] virtio-rng: skip reading when we start to remove
	the device
Date: Fri, 12 Sep 2014 11:07:26 +0930
Message-ID: <87r3zhhb55.fsf@rustcorp.com.au>
References: <1410329497-14349-1-git-send-email-akong@redhat.com>
	<1410329497-14349-3-git-send-email-akong@redhat.com>
	<20140910070444.GD29832@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140910070444.GD29832@grmbl.mre>
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
> On (Wed) 10 Sep 2014 [14:11:37], Amos Kong wrote:
>> Before we really unregister the hwrng device, reading will get stuck if
>> the virtio device is reset. We should return error for reading when we
>> start to remove the device.
>> 
>> Signed-off-by: Amos Kong <akong@redhat.com>
>> Cc: stable@vger.kernel.org
>
> Reviewed-by: Amit Shah <amit.shah@redhat.com>

Thanks, applied.

They're sitting in my fixes branch.  If there are no screams from
linux-next, I'll push to Linus Monday.

Cheers,
Rusty.
