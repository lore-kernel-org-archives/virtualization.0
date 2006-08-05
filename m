From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address
	space.
Date: Sat, 05 Aug 2006 15:52:46 -0700
Message-ID: <44D5213E.3000900@vmware.com>
References: <20060803002510.634721860@xensource.com>	<20060803002518.595166293@xensource.com>	<20060802231912.ed77f930.akpm@osdl.org>	<44D1A6B6.8040003@vmware.com>	<20060803004144.554d9882.akpm@osdl.org>	<44D1BAB8.8070509@vmware.com>
	<20060805145840.653912a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060805145840.653912a2.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: chrisw@sous-sol.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Thu, 03 Aug 2006 01:58:32 -0700
> Zachary Amsden <zach@vmware.com> wrote:
>
>   =

>> Add a bootparameter to reserve high linear address space for hypervisors.
>> This is necessary to allow dynamically loaded hypervisor modules, which
>> might not happen until userspace is already running, and also provides a
>> useful tool to benchmark the performance impact of reduced lowmem address
>> space.
>>     =

>
> Andi has gone and rotorooted the x86 boot parameter handling in there. =

> This patch now looks like this:
>   =


The rototilled patch looks great.  Acked.

Zach
