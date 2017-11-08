From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PULL] virtio: last minute bugfix
Date: Wed, 08 Nov 2017 09:24:57 +0800
Message-ID: <5A025CE9.3050103@intel.com>
References: <20171107172801-mutt-send-email-mst@kernel.org>
	<CA+55aFwfLmc4EnHJX6fpi79JZmxYMQSGinXHufHWZpSuJ2qPyA@mail.gmail.com>
	<CA+55aFw3ihA6wtL1L0TUf2o_WmVoft4RyrfG7x3iW407MtWmkg@mail.gmail.com>
	<20171107201156-mutt-send-email-mst@kernel.org>
	<20171107211730-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171107211730-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, KVM list <kvm@vger.kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/08/2017 03:23 AM, Michael S. Tsirkin wrote:
> On Tue, Nov 07, 2017 at 08:13:10PM +0200, Michael S. Tsirkin wrote:
>> On Tue, Nov 07, 2017 at 09:29:59AM -0800, Linus Torvalds wrote:
>>> On Tue, Nov 7, 2017 at 9:23 AM, Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>> I guess I'll take it, but please don't do things like this to me.
>>> Oh no I wont.
>>>
>>> The garbage you sent me doesn't even compile cleanly, and is utter shite.
>>>
>>> Not acceptable for last-minute bugfixes, and you're now on my shit-list.
>>>
>>>                  Linus
>> Sorry about that.
>>
>> I'll investigate what went wrong.
>>
>> Will be more careful not to cut corners next time around, just follow
>> the standard procedure.
> All right, my local tests didn't fail on new warnings, and I didn't give
> the zero day infrastructure enough time to do it's job.
>
> Lesson hopefully learned - don't rush it, give tools the time to do
> their job.
>
> Wei, you'll want to respin your 4.15 patchset on top of my fixed tree.
> At this point the fix will only land in 4.15, sorry about that.
>
> Thanks everyone.
>

OK, I'll use the fixed tree. Thanks, Michael.


Best,
Wei
