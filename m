From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 03/10] define ELF notes for adding to a boot image
Date: Fri, 15 Jun 2007 09:40:31 -0700
Message-ID: <4672C0FF.9080209__34573.3914793984$1181925698$gmane$org@goop.org>
References: <20070615004818.424726597@goop.org>
	<20070615005012.882738673@goop.org> <4672BC5B.1040502@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4672BC5B.1040502@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xen-Devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
>   
>> +#define EIN_PROGRAM_CHECKSUM	3 /* ip style checksum of the memory image. */
>>     
>
> Why on earth use one of the weakest verificants in common use?

I don't know.  I copied this stuff from the original relocatable kernel
patches; I think this is from Vivek.  Eric, Vivek: is there a specific
use for these notes?

    J
