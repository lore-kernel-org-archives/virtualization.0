Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC0EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 07:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4389408CD;
	Tue, 12 Apr 2022 07:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r6kcjwMsJDta; Tue, 12 Apr 2022 07:26:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E50814011C;
	Tue, 12 Apr 2022 07:26:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E0FFC0033;
	Tue, 12 Apr 2022 07:26:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0B10C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7828E60DFA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:26:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wr4HDcPL2ywi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:26:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6305060687
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649748383; x=1681284383;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gkhGiepzPyOKcCmGXkN+87sWY6kjgK6MU99iQQlt3gs=;
 b=bYgezipwarSpl1rtElh+SM2Cy7w0gSIOuB4JJFxfS1s473Ycxf7zVELG
 TllL5AtQrbr+51+cYrfKlt6KFJeAG+OwYMMuI+y13j+84879jtqk/9YXg
 puRQTKWGfBO86RuxDZtMg278Jd0cK2xk7pE4D2uJYkEmQw2C+IhNkpiXy
 xHParV5UVORiaWXkaW8+UrX/uLjkiSBAI5jbeq2P421HM5eUx6kAW8GH+
 lBKuk7UToBDaNbgtLYcpp8LTG2SidsYQdlLo6eX0rw+Qr5MGLYjzREPjv
 8J8ldS+44aZ38XhakIl+DZR6cERHtoW3i3kpnqrHcF+lWFJ8yyw4dmNmS w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244182267"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="244182267"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 00:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="802118281"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
 by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2022 00:26:17 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1neAum-0002ci-L0;
 Tue, 12 Apr 2022 07:26:16 +0000
Date: Tue, 12 Apr 2022 15:25:51 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v3 11/15] drm/shmem-helper: Add generic memory shrinker
Message-ID: <202204121504.gLR3FHQe-lkp@intel.com>
References: <20220411215937.281655-12-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220411215937.281655-12-dmitry.osipenko@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Dmitry,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20220411]
[cannot apply to drm/drm-next v5.18-rc2 v5.18-rc1 v5.17 v5.18-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Osipenko/Add-generic-memory-shrinker-to-VirtIO-GPU-and-Panfrost-DRM-drivers/20220412-060325
base:    d12d7e1cfe38e0c36d28c7a9fbbc436ad0d17c14
config: hexagon-randconfig-r045-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121504.gLR3FHQe-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/683ba8a9d72ba7770a61a9266a2b33949f3874f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dmitry-Osipenko/Add-generic-memory-shrinker-to-VirtIO-GPU-and-Panfrost-DRM-drivers/20220412-060325
        git checkout 683ba8a9d72ba7770a61a9266a2b33949f3874f2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_gem_shmem_helper.c:289:11: warning: variable 'new_state' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           else if (shmem->madv < 0)
                    ^~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_gem_shmem_helper.c:292:46: note: uninitialized use occurs here
           drm_gem_shmem_set_pages_state_locked(shmem, new_state);
                                                       ^~~~~~~~~
   drivers/gpu/drm/drm_gem_shmem_helper.c:289:7: note: remove the 'if' if its condition is always true
           else if (shmem->madv < 0)
                ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_gem_shmem_helper.c:278:2: note: variable 'new_state' is declared here
           enum drm_gem_shmem_pages_state new_state;
           ^
   1 warning generated.


vim +289 drivers/gpu/drm/drm_gem_shmem_helper.c

   273	
   274	static void drm_gem_shmem_update_pages_state_locked(struct drm_gem_shmem_object *shmem)
   275	{
   276		struct drm_gem_object *obj = &shmem->base;
   277		struct drm_gem_shmem_shrinker *gem_shrinker = obj->dev->shmem_shrinker;
   278		enum drm_gem_shmem_pages_state new_state;
   279	
   280		if (!gem_shrinker || obj->import_attach)
   281			return;
   282	
   283		mutex_lock(&gem_shrinker->lock);
   284	
   285		if (!shmem->madv)
   286			new_state = DRM_GEM_SHMEM_PAGES_STATE_ACTIVE;
   287		else if (shmem->madv > 0)
   288			new_state = DRM_GEM_SHMEM_PAGES_STATE_PURGEABLE;
 > 289		else if (shmem->madv < 0)
   290			new_state = DRM_GEM_SHMEM_PAGES_STATE_PURGED;
   291	
   292		drm_gem_shmem_set_pages_state_locked(shmem, new_state);
   293	
   294		mutex_unlock(&gem_shrinker->lock);
   295	}
   296	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
