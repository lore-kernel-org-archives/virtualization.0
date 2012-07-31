From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [vmw_vmci 00/11] VMCI for Linux
Date: Tue, 31 Jul 2012 08:48:38 -0400
Message-ID: <CA+5PVA615qJ+uJaHqCtYC45DF0E6A-wg+0_=xn2eCM-4O1-XVg__46339.5163802945$1343846619$gmane$org@mail.gmail.com>
References: <1343345980-32397-1-git-send-email-astiegmann@vmware.com>
	<CA+5PVA6RFthz5vjf-0BOogocMEwVKn5uE2q1_frjPFoVeUPACg@mail.gmail.com>
	<20120727014650.GB17168@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120727014650.GB17168@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, vm-crosstalk@vmware.com, "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>, cschamp@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 26, 2012 at 9:46 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Jul 26, 2012 at 09:06:25PM -0400, Josh Boyer wrote:
>> On Thu, Jul 26, 2012 at 7:39 PM, Andrew Stiegmann (stieg)
>> <astiegmann@vmware.com> wrote:
>> >  drivers/misc/Kconfig                      |    1 +
>> >  drivers/misc/Makefile                     |    1 +
>> >  drivers/misc/vmw_vmci/Kconfig             |   16 +
>>
>> Is there a reason this isn't going into staging first?  The Hyper-V
>> drivers went through staging and that actually seemed to work fairly
>> well.
>
> Is there some reason you feel this should be in the staging tree now?
> Why?

Apologies for the delayed reply.  Was on vacation.

Mostly because this is only one of several drivers.  One that the
other drivers depend on, and I don't see those posted at all.  I'm
guessing we'll want changes that will cause those unposted drivers to
break.  It just seems to make sense to work on the API in staging
rather than slam it into drivers/misc/.

josh
