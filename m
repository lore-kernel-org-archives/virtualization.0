From: Hubertus Franke <frankeh@watson.ibm.com>
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
Date: Tue, 12 Sep 2006 20:07:44 -0400
Message-ID: <45074BD0.3060400@watson.ibm.com>
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45073901.8020906@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rik van Riel <riel@redhat.com>
Cc: rhim@cc.gateh.edu, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Rik van Riel wrote:
> Martin Schwidefsky wrote:
> =

>> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> From: Hubertus Franke <frankeh@watson.ibm.com>
>> From: Himanshu Raj <rhim@cc.gatech.edu>
>>
>> [patch 1/9] Guest page hinting: unused / free pages.
>>
>> A very simple but already quite effective improvement in the handling
>> of guest memory vs. host memory is to tell the host when pages are
>> free. =

> =

> =

> Would it be an idea to place this interface in-between the
> per-cpu free page lists and the buddy allocator, so we can
> move a batch of pages around at once and do the hinting in
> a batched fashion ?
> =

> That way the overhead will be acceptable not just on S390
> (where things are millicoded), but also on hypervisor based
> virtualization like Xen.
> =

> Easy enough to pass a vector of pages to the hypervisor.
> =


Rik, I thought that what we did.
Martin, I see the code actually does it when the page goes into the hot/cold
list. I can't remember conciously moving to that.
I thought we had a decent hit on the hot/cold, so that bulking makes sense.

Then the interface of bulking could be introduced and for s390 it could int=
ernally
be implemented as a sequence of ESSA instruction.
Do you remember the reason why we ended up putting it as part of hot/cold f=
reeing?

-- Hubertus
