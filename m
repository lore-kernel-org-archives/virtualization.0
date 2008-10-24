From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [Question] power management related with cgroup based resource
	management
Date: Sat, 25 Oct 2008 00:25:03 +0100
Message-ID: <20081024232503.GA20140__8989.10129112682$1224892299$gmane$org@srcf.ucam.org>
References: <2891419e0810201954q57087fc8ufcaa0e42f3ca99e2@mail.gmail.com>
	<4901B5C2.9070108@linux.vnet.ibm.com>
	<2891419e0810240524u746b731cjcbd127fa4204bd4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <2891419e0810240524u746b731cjcbd127fa4204bd4d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dong-Jae Kang <baramsori72@gmail.com>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, corsetproject@googlegroups.com, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 24, 2008 at 09:24:21PM +0900, Dong-Jae Kang wrote:

> I am interested in power management in server side.
> and I just wonder this question, "Is there any related point between
> cgroup framework and power management?"

Not currently, though it would certainly be possible to use cgroups as a 
mechanism for providing application-specific power management.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
