From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFCv2 00/12] Introduce host-side virtio queue and CAIF Virtio.
Date: Fri, 11 Jan 2013 15:52:34 +0100
Message-ID: <CAJK669b9D_NNhtg=nE+beM9xaqQbrbD3wJqqhCCG62WavdqpSg@mail.gmail.com>
References: <871ug75vp1.fsf@rustcorp.com.au>
	<1354718230-4486-1-git-send-email-sjur@brendeland.net>
	<20121206102750.GF10837@redhat.com>
	<877goc0wac.fsf@rustcorp.com.au>
	<CAJK669bP41oBhJ=MB64NS21Ag7XO5WswuTiVKCFTb96nvmyBiw@mail.gmail.com>
	<87pq1f2rj0.fsf@rustcorp.com.au> <87wqvl1g9s.fsf@rustcorp.com.au>
	<CAJK669Z-bGTeQe8qJpTJP7simbSvQ8cgFZefs5QRMkmxtFYY4g@mail.gmail.com>
	<87pq1c1uj4.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87pq1c1uj4.fsf@rustcorp.com.au>
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
Cc: Linus Walleij <linus.walleij@linaro.org>, virtualization@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 11, 2013 at 12:35 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Hi Sjur!
>
>         OK, the Internet was no help here, how do you pronounce Sjur?
> I'm guessing "shoor" rhyming with tour until I know better.

Thank you for asking! This is pretty close yes.
I usually tell people to pronounce it like "sure" for simplicity.
But Google translate has a perfect Norwegian voice pronouncing my name:
http://translate.google.com/#auto/no/sjur (Press the speaker button)

While at the subject: Norwegian names can be a laugh: I have people
named "Odd" and "Even" in my family, and I once had a friend named
"Aashold".

...

>> I would prefer not to split into pages at this point, but rather provide an
>> iterator or the original list found in the descriptor to the client.
...
> In other words, boundaries matter?
>
> While the sg-in-place hack is close to optimal for TCM_VHOST, neither
> net not you can use it directly.  I'll switch to an iovec (with a
> similar use-caller-supplied-if-it-fits trick); they're smaller anyway.

Great, I think iovec will be a good fit for my CAIF driver.

Thanks,
Sjur
