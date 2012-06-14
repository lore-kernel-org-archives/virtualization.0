From: Jens Axboe <axboe@kernel.dk>
Subject: Re: drivers/block/cpqarray.c:938:2: error: too many arguments to
	function lk_rq_map_sg
Date: Thu, 14 Jun 2012 12:45:38 +0200
Message-ID: <4FD9C0D2.20500__25473.0415683754$1339682773$gmane$org@kernel.dk>
References: <4fd91c3f.KAwMcygw9fFGn9Cx%wfg@linux.intel.com>
	<4FD984F3.3070502@kernel.dk> <20120614090151.GA12013@localhost>
	<4FD9A95D.40903@kernel.dk> <20120614100205.GA13217@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120614100205.GA13217@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fengguang Wu <wfg@linux.intel.com>
Cc: linux-raid@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 06/14/2012 12:02 PM, Fengguang Wu wrote:
> On Thu, Jun 14, 2012 at 11:05:33AM +0200, Jens Axboe wrote:
>> On 06/14/2012 11:01 AM, Fengguang Wu wrote:
>>> Hi Jens,
>>>
>>> On Thu, Jun 14, 2012 at 08:30:11AM +0200, Jens Axboe wrote:
>>>> On 06/14/2012 01:03 AM, wfg@linux.intel.com wrote:
>>>>> FYI, kernel build failed on
>>>>>
>>>>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git multiqueue
>>>>> head:   e9a6aa8a0b7b93195774a9fcf551632bf3abcd97
>>>>> commit: 67db7275fa4325d46853a4bfcb79acf32e48eca8 [1/3] multiqueue: a hodge podge of things
>>>>
>>>> The multiqueue branch is a private branch, it's known broken on many
>>>> configs at the moment.
>>>
>>> OK. Sorry my script just blindly build tests every new/updated branches
>>> in the tree. It does try to reduce noise level by remembering all warned
>>> error messages. However if it still presents a problem to the private
>>> branches, I can either explicitly blacklist "multiqueue", or let the
>>> script automatically skip commits whose "^Signed-off-by:" is still missing.
>>
>> It's not a problem that you're building various branches, as long as you
>> are expecting a bit of noise :-). In fact I applaud your effort on
>> expanding the scope of building others branches.
>>
>> But it does raise the question of how do we best signal intermediate
>> branches like this, so they can be avoided until they are ready. The
>> blacklist doesn't seem like a great choice, since then I have to
>> remember to remind you when it _is_ ok to build it.
>>
>> How about some arbitrary tag? Instead of checking a Signed-off-by, I
>> could just add a Dont-Auto-Build or something like that. What do you
>> think?
> 
> OK, I'll add a grep for "Dont-Auto-Build". If it's found in *any*
> commit of the branch, the build script will skip the whole branch.
> Does this make sense to you?

Yeah that'll work for me. A description or tag might be more elegant,
but this is easier...

-- 
Jens Axboe
