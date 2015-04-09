From: "Xie, Huawei" <huawei.xie@intel.com>
Subject: RE: [dpdk-dev] [snabb-devel] Re: memory barriers in virtq.lua?
Date: Thu, 9 Apr 2015 15:00:32 +0000
Message-ID: <C37D651A908B024F974696C65296B57B0F4300E6__19645.3525255949$1428591671$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <20150127160126.GA10651@redhat.com>
	<CADDJ2=M6hwFwooXqUjUc9+JxjW1sVYvKhY9dBavrmMUrej6Ysw@mail.gmail.com>
	<CAA2XHbcU0tV0NrBXT6oh6LOz7sKm9P8jqD1=T-ZgTahSVM_qwQ@mail.gmail.com>
	<C37D651A908B024F974696C65296B57B0F42E766@SHSMSX101.ccr.corp.intel.com>
	<CAA2XHbdNAB1ZsBFYHW7W1yhnkzaSixwKk4KvjU8G=7OLECpZhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAA2XHbdNAB1ZsBFYHW7W1yhnkzaSixwKk4KvjU8G=7OLECpZhQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Luke Gorrie <luke@snabb.co>, "snabb-devel@googlegroups.com" <snabb-devel@googlegroups.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: dev [mailto:dev-bounces@dpdk.org] On Behalf Of Luke Gorrie
> Sent: Thursday, April 09, 2015 11:13 AM
> To: snabb-devel@googlegroups.com
> Cc: dev@dpdk.org; VirtualOpenSystems Technical Team; Michael S. Tsirkin;
> virtualization@lists.linux-foundation.org
> Subject: Re: [dpdk-dev] [snabb-devel] Re: memory barriers in virtq.lua?
> 
> Howdy,
> 
> On 8 April 2015 at 17:15, Xie, Huawei <huawei.xie@intel.com> wrote:
> 
> > luke:
> > 1. host read the flag. 2 guest toggles the flag 3.guest checks the used.
> > 4. host update used.
> > Is this your case?
> >
> 
> Yep, that is exactly the case I mean.
Thanks. Will provide fix after evaluation.
> 
> Cheers,
> -Luke
