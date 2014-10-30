From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2 4/6] hw_random: fix unregister race.
Date: Fri, 31 Oct 2014 10:28:00 +1030
Message-ID: <87y4rx860n.fsf@rustcorp.com.au>
References: <1411043867-21109-1-git-send-email-akong@redhat.com>
	<1411043867-21109-5-git-send-email-akong@redhat.com>
	<20141021141745.GA18511@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141021141745.GA18511@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>, Amos Kong <akong@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, m@bues.ch, mpm@selenic.com, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Herbert Xu <herbert@gondor.apana.org.au> writes:
> On Thu, Sep 18, 2014 at 08:37:45PM +0800, Amos Kong wrote:
>> From: Rusty Russell <rusty@rustcorp.com.au>
>> 
>> The previous patch added one potential problem: we can still be
>> reading from a hwrng when it's unregistered.  Add a wait for zero
>> in the hwrng_unregister path.
>> 
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> You totally corrupted Rusty's patch.  If you're going to repost
> his series you better make sure that you've got the right patches.
>
> Just as well though as it made me think a little more about this
> patch :)

OK Amos, can you please repost the complete series?

Thanks,
Rusty.
