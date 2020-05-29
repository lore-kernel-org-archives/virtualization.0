From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [RFC 05/12] ASoC: SOF: add two helper lookup functions
Date: Fri, 29 May 2020 09:37:15 +0200
Message-ID: <20200529073722.8184-6-guennadi.liakhovetski@linux.intel.com>
References: <20200529073722.8184-1-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200529073722.8184-1-guennadi.liakhovetski@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: kvm@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, linux-remoteproc@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, virtualization@lists.linux-foundation.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, sound-open-firmware@alsa-project.org
List-Id: virtualization@lists.linuxfoundation.org

Add two helper lookup functions for finding a widget by its component
ID and a DAI by a pipeline ID.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/sof/sof-audio.c | 24 ++++++++++++++++++++++++
 sound/soc/sof/sof-audio.h |  5 +++++
 sound/soc/sof/topology.c  |  1 +
 3 files changed, 30 insertions(+)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 1c7698f..92fa6a8 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -395,6 +395,30 @@ struct snd_sof_dai *snd_sof_find_dai(struct snd_soc_component *scomp,
 	return NULL;
 }
 
+struct snd_sof_widget *snd_sof_find_swidget_id(struct snd_sof_dev *sdev,
+					       unsigned int comp_id)
+{
+	struct snd_sof_widget *swidget;
+
+	list_for_each_entry(swidget, &sdev->widget_list, list)
+		if (swidget->comp_id == comp_id)
+			return swidget;
+
+	return NULL;
+}
+
+struct snd_sof_dai *snd_sof_find_dai_pipe(struct snd_sof_dev *sdev,
+					  unsigned int pipeline_id)
+{
+	struct snd_sof_dai *dai;
+
+	list_for_each_entry(dai, &sdev->dai_list, list)
+		if (dai->pipeline_id == pipeline_id)
+			return dai;
+
+	return NULL;
+}
+
 /*
  * SOF Driver enumeration.
  */
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 9629994..8054e48 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -106,6 +106,7 @@ struct snd_sof_dai {
 	struct snd_soc_component *scomp;
 	const char *name;
 	const char *cpu_dai_name;
+	unsigned int pipeline_id;
 
 	struct sof_ipc_comp_dai comp_dai;
 	struct sof_ipc_dai_config *dai_config;
@@ -190,6 +191,10 @@ struct snd_sof_pcm *snd_sof_find_spcm_comp(struct snd_soc_component *scomp,
 					   int *direction);
 struct snd_sof_pcm *snd_sof_find_spcm_pcm_id(struct snd_soc_component *scomp,
 					     unsigned int pcm_id);
+struct snd_sof_widget *snd_sof_find_swidget_id(struct snd_sof_dev *sdev,
+					       unsigned int comp_id);
+struct snd_sof_dai *snd_sof_find_dai_pipe(struct snd_sof_dev *sdev,
+					  unsigned int pipeline_id);
 void snd_sof_pcm_period_elapsed(struct snd_pcm_substream *substream);
 void snd_sof_pcm_period_elapsed_work(struct work_struct *work);
 
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 6a9703e..5a65dcf 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1406,6 +1406,7 @@ static int sof_widget_load_dai(struct snd_soc_component *scomp, int index,
 
 	if (ret == 0 && dai) {
 		dai->scomp = scomp;
+		dai->pipeline_id = swidget->pipeline_id;
 		memcpy(&dai->comp_dai, &comp_dai, sizeof(comp_dai));
 	}
 
-- 
1.9.3
