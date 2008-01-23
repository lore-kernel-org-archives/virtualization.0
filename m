From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 0/2] dm-band: The I/O bandwidth controller: Overview
Date: Wed, 23 Jan 2008 15:32:35 +0100
Message-ID: <1201098755.6341.54.camel__36074.5970778682$1201103202$gmane$org@lappy>
References: <20080123.215350.193721890.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080123.215350.193721890.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: containers@lists.linux-foundation.org, dm-devel@redhat.com, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On Wed, 2008-01-23 at 21:53 +0900, Ryo Tsuruta wrote:
> Hi everyone,
> 
> I'm happy to announce that I've implemented a Block I/O bandwidth controller.
> The controller is designed to be of use in a cgroup or virtual machine
> environment. The current approach is that the controller is implemented as
> a device-mapper driver.

What definition of bandwidth does it use? Does it for example account
for seek latency?
