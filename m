From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: RFC: Network Plugin Architecture (NPA) for vmxnet3
Date: Tue, 4 May 2010 19:44:19 -0700
Message-ID: <20100504194419.2ce32117__8013.81937130845$1273027524$gmane$org@nehalam>
References: <20100504230225.GP8323@vmware.com>
	<20100504170531.1e7122da@nehalam>
	<20100505001857.GQ8323@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505001857.GQ8323@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pankaj Thakkar <pthakkar@vmware.com>
Cc: "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 4 May 2010 17:18:57 -0700
Pankaj Thakkar <pthakkar@vmware.com> wrote:

> The purpose of this email is to introduce the architecture and the design principles. The overall project involves more than just changes to vmxnet3 driver and hence we though an overview email would be better. Once people agree to the design in general we intend to provide the code changes to the vmxnet3 driver.

As Dave said, we care more about what the implementation looks like than the high level
goals of the design. I think we all agree that better management of virtualized devices
is necessary, the problem is that their are so many of them (vmware, xen, HV, Xen), 
and vendors seem to to lean on their own specific implementation of a offloading, 
which makes a general solution more difficult. Please, Please solve this cleanly.

The little things like API's and locking semantics and handling of dynamic versus
static control can make a good design in principle fall apart when someone does a bad
job of implementing them.

Lastly, projects that have had multiple people involved for long periods of time
in the dark often end up building a legacy mentality "but we convinced vendor XXX to include it
in their Enterprise version 666" and require lots of "retraining" before the code
becomes acceptable.

-- 
