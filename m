From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH v2 34/37] docs: fix locations of several documents that
	got moved
Date: Wed, 02 Nov 2016 06:08:43 -0400
Message-ID: <5819BB2B.7010404__23372.1640463502$1479775351$gmane$org@redhat.com>
References: <cover.1476801354.git.mchehab@s-opensource.com>
	<28c1f5d3867174a7017e3f3d9e9e4ebb096ceed8.1476801354.git.mchehab@s-opensource.com>
	<20161019103442.GD1461@amd> <20161019115918.1162d16e@vento.lan>
	<20161102093154.GC23350@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161102093154.GC23350@amd>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Chris Metcalf <cmetcalf@ezchip.com>, Peter Loeffler <peter.loeffler@guruz.at>, Finn Thain <fthain@telegraphics.com.au>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Jakub Wilk <jwilk@jwilk.net>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Guenter Roeck <linux@roeck-us.net>, Petr Mladek <pmladek@suse.com>, Jean Delvare <jdelvare@suse.com>, linux-pm@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Karsten Keil <isdn@linux-pingi.de>, Jiri Kosina <jkosina@suse.cz>, "seokhoon.yoon" <iamyooon@gmail.com>, Li Zefan <lizefan@huawei.com>, Ryan Swan <ryan@ryanswan.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Mark
List-Id: virtualization@lists.linuxfoundation.org



On 11/02/2016 05:31 AM, Pavel Machek wrote:
> Hi!
> 
>>> Dunno, but kernel-parameters.txt was already quite long... for a file
>>> that is referenced quite often. Adding admin-guide/ into the path does
>>> not really help.
>>
>> The big string name starts with Documentation/ :) There are some discussions 
>> about changing it to doc/ (or docs/). Also, as you said, kernel-parameters
>> is already a big name. Perhaps we could use, instead,
>>> "kernel-parms".
> 
> cmdline?

You would not believe the number of users I've dealt with that have confused
"cmdline/command line" (aka prompt) with "kernel parameter".  I go back and edit
customer debug requests to make sure there's no use of cmdline in place of
kernel parameter.

For the love of every customer facing engineer out there, please stop using
cmdline ;).

P.

> 
>> If we rename kernel-parameters.rst to kernel-parms.rst, plus the doc/ rename,
>> then the string size will actually reduce:
>>
>> -		(see Documentation/kernel-parameters.txt), the minimum possible
>> +		(see doc/admin-guide/kernel-parms.rst), the minimum possible
>>
>>> Maybe admin-guide should go directly into Documentation/ , as that's
>>> what our users are interested in?
>>
>> There are several problems if we keep them at Documentation/ dir:
>>
>> - We'll end by mixing documents already converted to ReST with documents
>>   not converted yet;
>>
>> - A rename is needed anyway, as Sphinx only accepts ReST files that end
>>   with the extension(s) defined at Documentation/conf.py (currently,
>>   .rst);
>>
>> - A partial documentation build is made by sub-directory. If we put
>>   files under /Documentation, there's no way to build just one
>>   book.
> 
> Well, documentation is primarily for users. I'm sure tools can adapt...
> 
>>> Plus, I'm not sure how many developers will figure out that process/
>>> is what describes kernel patch submission process. We have processes
>>> in the kernel, after all...
>>
>> Do you have a better idea?
> 
> development/ ?
> 
> Best regards,
> 									Pavel
> 
