From: "Glauber Costa" <glommer@gmail.com>
Subject: Re: [PATCH] Do not calculate linear rip in emulation failure report
Date: Sat, 14 Jun 2008 00:43:11 -0300
Message-ID: <5d6222a80806132043x621ec290sbfd42e33e06843b5__4639.42052233524$1213415118$gmane$org@mail.gmail.com>
References: <1213105613-8571-1-git-send-email-gcosta@redhat.com>
	<52d4a3890806131033g56ec2bc0o43442d2c290401f2@mail.gmail.com>
	<5d6222a80806131037u245c66ev902fadaa6d5c4605@mail.gmail.com>
	<4852CE93.9020104@qumranet.com>
	<5d6222a80806131251q12fbbff0rc90a133722acf2d7@mail.gmail.com>
	<4853298C.7090109@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4853298C.7090109@qumranet.com>
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
To: Avi Kivity <avi@qumranet.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Glauber Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 13, 2008 at 11:14 PM, Avi Kivity <avi@qumranet.com> wrote:
> Glauber Costa wrote:
>>>
>>> I've changed it to use printk_ratelimit().
>>>
>>
>> I've tested this option here before sending out the patch, since it
>> would address all issues.
>>
>> But in error cases, it still seemed to generate too many messages.
>>
>>
>
> Isn't that a bug in printk_ratelimit(), then?

I don't think so. It wasn't enough messages to DoS the system.
Just enough messages to annoy me.

That said, If the general feeling is that we should really be seeing
more than the first message, I'm okay with the ratelimit too.
> --
> I have a truly marvellous patch that fixes the bug which this
> signature is too narrow to contain.
>
>



-- 
Glauber  Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
