From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: another RFC patch: bzImage with ELF payload
Date: Fri, 01 Jun 2007 13:20:45 -0600
Message-ID: <m1lkf3zdki.fsf@ebiederm.dsl.xmission.com>
References: <46605E3D.3030009@goop.org> <46605ED4.6040202@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46605ED4.6040202@goop.org> (Jeremy Fitzhardinge's message of
	"Fri, 01 Jun 2007 11:00:52 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Jeremy Fitzhardinge wrote:
>> BTW, this won't apply as-is; I have some mucking-around patches to try
>> and get the linux/elf*.h headers into a bit more order, but that's not
>> ready yet.
>>   
>
> BTW2: I've been basically ignoring zImage.  Do we need to support it at
> all?  Has anyone used it in the last 10 years?

zImage is uninteresting.  I think HPA explicitly dropped support a few
years ago so we can't even build it.

That said a bImage (non-compressed bzImage).  Might actually be
interesting.

The kernel image history is:

Image:   -- noncompressed image loaded  below 1M.
zImage:  -- compressed image loaded below 1M.
bzImage: -- compressed image loaded above 1M.

For people who want to compress it themselves a
bImage:  -- non-compressed image loaded above 1M.
could be interesting.

Eric
