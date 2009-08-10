From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2] export cpu_tlbstate to modules
Date: Mon, 10 Aug 2009 15:24:50 -0700
Message-ID: <4A809E32.6060206__41415.2650665075$1249943189$gmane$org@zytor.com>
References: <cover.1249930169.git.mst@redhat.com>
	<20090810185302.GB13924@redhat.com> <4A80979E.3080204@zytor.com>
	<20090810220613.GA17099@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090810220613.GA17099@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, mingo@elte.hu, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/10/2009 03:06 PM, Michael S. Tsirkin wrote:
>> Wouldn't it be a *lot* better to move use_mm() from fs/aio.c into common
>> code, and export that instead?
> 
> That's easy too. What would a good place for it be?

Somewhere in mm/, presumably.  When in doubt, make it a new file...
	
	-hpa
