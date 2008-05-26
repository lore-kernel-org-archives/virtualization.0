From: "Glauber Costa" <glommer@gmail.com>
Subject: Re: kvm-lite, lguest64: status?
Date: Sun, 25 May 2008 23:28:19 -0300
Message-ID: <5d6222a80805251928s51b9e327gd2cc8a98702af30c@mail.gmail.com>
References: <4836C2C7.4010903@redhat.com>
	<200805261109.01065.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805261109.01065.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, May 25, 2008 at 10:09 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Friday 23 May 2008 23:12:39 Gerd Hoffmann wrote:
>>   Hi,
>>
>> Just a quick question:  What is the status of the two projects in
>> $subject?  Havn't heared anything for a while for both ...
>
> Hi Gerd,
>
>    lguest64 I'll punt to Glauber.  For kvm-lite, frankly there wasn't enough
> interest, and I wasn't going to continue it by myself: IBM certainly (and
> correctly) sees virtio as more important.

lguest64 has a working version, but is a little bit old. I was in the
middle of an effort to merge it with lguest32 (If I can call it this
way to avoid ambiguity ;-)) in linus tree, but I was
preempted due to higher privileged tasks gettin into the stack. Same
reason is keeping rostedt away.


-- 
Glauber Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
