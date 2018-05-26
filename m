From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v12 1/5] net: Introduce generic failover module
Date: Sat, 26 May 2018 09:43:16 +0200
Message-ID: <20180526074316.GB4288__14538.4922660471$1527320516$gmane$org@nanopsycho.orion>
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
	<1527180917-39737-2-git-send-email-sridhar.samudrala@intel.com>
	<20180525153744.2b53c449@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180525153744.2b53c449@xeon-e3>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, anjali.singhai@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Sat, May 26, 2018 at 12:37:44AM CEST, stephen@networkplumber.org wrote:
>On Thu, 24 May 2018 09:55:13 -0700
>Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>
>
>> +	spin_lock(&failover_lock);
>
>Since register is not in fast path, this should be a mutex?

I don't get it. Why would you prefer mutex over spinlock here?
