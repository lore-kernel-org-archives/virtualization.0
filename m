From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] Add a page cache-backed balloon device driver.
Date: Mon, 10 Sep 2012 14:04:08 -0400
Message-ID: <504E2B98.3010007@redhat.com>
References: <1340742778-11282-1-git-send-email-fes@google.com>
	<20120910090521.GB18544@redhat.com>
	<CAGTjWtBa5jW6+y1k6zZmD9TUNHBgv8WRbO_iy7huY_dJSumStw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGTjWtBa5jW6+y1k6zZmD9TUNHBgv8WRbO_iy7huY_dJSumStw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mike Waychison <mikew@google.com>
Cc: Frank Swiderski <fes@google.com>, Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/10/2012 01:37 PM, Mike Waychison wrote:
> On Mon, Sep 10, 2012 at 5:05 AM, Michael S. Tsirkin <mst@redhat.com> wrote:

>> Also can you pls answer Avi's question?
>> How is overcommit managed?
>
> Overcommit in our deployments is managed using memory cgroups on the
> host.  This allows us to have very directed policies as to how
> competing VMs on a host may overcommit.

How do your memory cgroups lead to guests inflating their balloons?

-- 
All rights reversed
