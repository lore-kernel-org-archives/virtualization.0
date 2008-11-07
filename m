From: Yu Zhao <yu.zhao@uniscape.net>
Subject: Re: git repository for SR-IOV development?
Date: Fri, 07 Nov 2008 21:09:20 +0800
Message-ID: <49143E00.30003__21418.5859812007$1226063762$gmane$org@uniscape.net>
References: <20081106165914.GA13476@kroah.com>
	<104014.9320.qm@web45110.mail.sp1.yahoo.com>
	<20081107015844.GA11884@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081107015844.GA11884@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: H L <swdevyid@yahoo.com>
Cc: randy.dunlap@oracle.com, Xen-devel List <xen-devel@lists.xensource.com>, grundler@parisc-linux.org, achiang@hp.com, matthew@wil.cx, Greg KH <greg@kroah.com>, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Hello Lance,

Thanks for your interest in SR-IOV. As Greg said we can't have a git 
tree for the change, but you are welcome to ask any question here and I 
also will keep you informed if there is any update on the SR-IOV patches.

Thanks,
Yu

Greg KH wrote:
> On Thu, Nov 06, 2008 at 11:58:25AM -0800, H L wrote:
>> --- On Thu, 11/6/08, Greg KH <greg@kroah.com> wrote:
>>
>>> On Thu, Nov 06, 2008 at 08:51:09AM -0800, H L wrote:
>>>> Has anyone initiated or given consideration to the
>>> creation of a git
>>>> repository (say, on kernel.org) for SR-IOV
>>> development?
>>>
>>> Why?  It's only a few patches, right?  Why would it
>>> need a whole new git
>>> tree?
>>
>> So as to minimize the time and effort patching a kernel, especially if
>> the tree (and/or hash level) against which the patches were created
>> fails to be specified on a mailing-list.  Plus, there appears to be
>> questions raised on how, precisely, the implementation should
>> ultimately be modeled and especially given that, who knows at this
>> point what number of patches will ultimately be submitted?  I know
>> I've built the "7-patch" one (painfully, by the way), and I'm aware
>> there's another 15-patch set out there which I've not yet examined.
> 
> It's a mere 7 or 15 patches, you don't need a whole git tree for
> something small like that.
> 
> Especially as there only seems to be one developer doing real work...
> 
> thanks,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
