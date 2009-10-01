From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: INFO: task journal:337 blocked for more than 120 seconds
Date: Thu, 1 Oct 2009 10:20:12 -0300
Message-ID: <20091001132012.GA16975__27624.5961119004$1254403294$gmane$org@amt.cnet>
References: <1254345112.8837.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1254345112.8837.9.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shirley Ma <mashirle@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 30, 2009 at 02:11:52PM -0700, Shirley Ma wrote:
> Hello all,
> 
> Anybody found this problem before? I kept hitting this issue for 2.6.31
> guest kernel even with a simple network test.
> 
> INFO: task kjournal:337 blocked for more than 120 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_sec" disables this message.
> 
> kjournald	D 00000041	0	337	2 0x00000000
> 
> My test is totally being blocked.

I've hit this in the past with ext3, mounting with data=writeback made it
disappear.
