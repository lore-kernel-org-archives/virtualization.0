From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv4] virtio_console: Add support for remoteproc serial
Date: Tue, 25 Sep 2012 14:55:04 +0930
Message-ID: <87sja63c9b.fsf@rustcorp.com.au>
References: <1348489987-6768-1-git-send-email-sjur.brandeland@stericsson.com>
	<20120924174523.GA14390@amit.redhat.com>
	<81C3A93C17462B4BBD7E272753C1057923BD79D728@EXDCVYMBSTM005.EQ1STM.local>
	<20120925040158.GC32657@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120925040158.GC32657@amit.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Cc: "sjurbren@gmail.com" <sjurbren@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S.  Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:

> On (Mon) 24 Sep 2012 [23:50:01], Sjur BRENDELAND wrote:
>> Hi Amit,
>> 
>> > I'm sorry for not being able to look at this earlier.
>> 
>> No worries. I'll try to respin and retest this patch by tomorrow.
>> If you by any chance could find time to review so could make it in time
>> for 3.7 it would be great :-)
>
> I think it might be late for 3.7 already, I'd prefer to let this bake
> for a while, ensure it passes my test suites, at the least.  But I'll
> let Rusty take the final call.

It can make the next merge window, but it has to be done this week.

I'm only allowing it this late because it's a new driver.

Cheers,
Rusty.
